# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate!, only: [:index]

  def index
    unless current_user
      render "public_index"
      return
    end

    load_posts_from_sources

    respond_to do |format|
      format.turbo_stream if params[:last_source_id]
      format.html
    end
  end

  def navbars = render(partial: "navbars")

  def test_submit
    #    sleep 3
    #    redirect_to "/"
    #    return

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.append("haha", "<p>WEEE #{params[:name]}</p>")
      end
      format.html { redirect_to "/" }
    end
  end

  private

  def load_posts_from_sources
    @posts = []

    load_sources.each do |source|
      next if @posts.length > 20

      @posts.concat source.posts.includes(:feed).order(published_at: :desc).limit(5)
    end
  end

  # rubocop:todo Metrics/AbcSize, Style/MultilineBlockChain
  def load_sources
    if params[:last_source_id]
      session[:timeline_source_ids]             => ids
      Source.where(id: ids).to_a.group_by(&:id) => source_index
      ids.map { |i| source_index[i].first }     => sources

      sources.index { |source| source.id == params[:last_source_id].to_i } + 1 => last_index
      sources[last_index..]
    else
      current_user
        .sources
        .then do |query|
          if params[:tag]
            query.joins(subscriptions: :tags).where("tags.name = ?", params[:tag])
          else
            query
          end
        end
        .where.not(latest_post_at: nil)
        .order(latest_post_at: :desc)
        .tap { |sources| session[:timeline_source_ids] = sources.map(&:id) }
    end
  end
  # rubocop:enable Metrics/AbcSize, Style/MultilineBlockChain
end
