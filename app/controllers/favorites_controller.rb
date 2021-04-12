# frozen_string_literal: true

class FavoritesController < ApplicationController
  def index
    @posts = Post
      .joins(:post_actions)
      .merge(PostAction.by_user(current_user).favorite)
      .order(published_at: :desc)

    respond_to do |format|
      format.turbo_stream if params[:last_post_id]
      format.html
    end
  end

  def toggle
    Post
      .find(params[:id])
      .toggle_favorite_for_user

    head :created
  end
end
