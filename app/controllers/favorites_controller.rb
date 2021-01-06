# frozen_string_literal: true

class FavoritesController < ApplicationController
  def index
    @posts = Post.joins(:post_actions).merge(PostAction.favorite).order(published_at: :desc)

    respond_to do |format|
      format.turbo_stream if params[:last_post_id]
      format.html
    end
  end
end
