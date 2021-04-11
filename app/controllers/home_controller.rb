# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    load_posts_from_sources

    respond_to do |format|
      format.turbo_stream if params[:last_source_id]
      format.html
    end
  end

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
    if params[:last_source_id]
      ids = session[:timeline_source_ids]
      source_index = Source.where(id: ids).to_a.group_by(&:id)
      sources = ids.map { |i| source_index[i].first }

      index = sources.index { |source| source.id == params[:last_source_id].to_i }
      sources = sources[(index + 1)..]
    else
      sources = Source.where.not(latest_post_at: nil).order(latest_post_at: :desc)
      session[:timeline_source_ids] = sources.map(&:id)
    end

    sources.each do |source|
      next if @posts.length > 20

      @posts.concat source.posts.includes(:feed).order(published_at: :desc).limit(5)
    end
  end
end
