# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :require_login, only: [:index, :beta_thanks]
  # rubocop:todo Metrics/PerceivedComplexity
  # rubocop:todo Metrics/MethodLength
  # rubocop:todo Metrics/AbcSize
  def index # rubocop:todo Metrics/CyclomaticComplexity
    return "foo" if @bar == "bar"

    if current_user.nil?
      # Not Logged In public homepage
      render "public", layout: "bigdesign"
      return
    end

    @pagetitle = "My Feeds"

    determine_view_type

    if params[:collection_id]
      if params[:collection_id] == "all"
        session.delete(:show_collection_id)
      else
        session[:show_collection_id] = params[:collection_id]
      end
    end

    @current_collection = if session[:show_collection_id].present?
                            Collection.find_by_id(session[:show_collection_id]) # could be nil
                          end

    @data_stores = current_user.data_stores.order(:title)
    if @current_collection
      @data_stores = @data_stores.where(id: @current_collection.data_stores.pluck(:id))
    end
    @data_stores = @data_stores.where(indie: true) if @view_type == :indie

    @posts = []
    @collections = current_user.collections.order(:title)

    if request.xhr?
      @posts = case @view_type
               when :indie
                 current_user.indie_timeline(@data_stores)
               when :summary
                 @pinned_data_store_ids = params[:no_pins] ? [] : current_user.data_store_pins.pluck(:data_store_id)
                 current_user.summary_timeline(@data_stores, @pinned_data_store_ids)
               else
                 current_user.timeline(@data_stores)
               end
      #      if @view_type == :today
      #        @posts = current_user.today_view(@posts)
      #      end

      @posts = @posts.page(params[:page]).per(10)
      load_post_actions_for(@posts)

      render layout: nil
    else
      @placeholder = true
    end
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/PerceivedComplexity

  def beta_thanks
    render layout: "bigdesign"
  end

  def community_standards
    render layout: "bigdesign"
  end

  def readlist # rubocop:todo Metrics/AbcSize
    @last_7_days = current_user.post_actions.readlist.includes(post: :data_store).where(created_at: 7.days.ago..Time.now).order("post_actions.created_at DESC").reject { |item| item.post.nil? }

    @today_added = @last_7_days.select { |item| item.created_at >= Date.current }
    @recently_added = @last_7_days.reject { |item| item.created_at >= Date.current }

    load_post_actions_for(@last_7_days.map(&:post))

    @pagetitle = "Readlist"
  end

  def admin
    require_admin

    # jumping off point to other things
  end

  def theme
    case params[:darkmode]
    when "true"
      session[:darkmode] = "true"
    when "false"
      session.delete :darkmode
    end

    render js: "document.documentElement.classList.toggle('dark-mode');document.querySelectorAll('.change-themes').forEach(item => item.classList.toggle('is-hidden'))"
  end

  private

  def determine_view_type
    # Deleting all the other views… # rubocop:todo Style/AsciiComments
    #    if params[:view_type].in? ['card', 'list', 'today', 'indie', 'summary']
    #      cookies.permanent[:view_type] = params[:view_type]
    #    elsif cookies[:view_type].nil?
    cookies.permanent[:view_type] = "summary"
    #    end

    @view_type = cookies[:view_type].to_sym
    @view_type = :summary if @view_type == :today # change
  end
end
