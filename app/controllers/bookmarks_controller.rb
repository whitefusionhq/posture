# frozen_string_literal: true

class BookmarksController < ApplicationController
  def index
    # TODO: add pagination!
    @posts = Post
      .joins(:post_actions)
      .merge(PostAction.by_user(current_user).bookmark)
      .order(published_at: :desc)
      .limit(30)

    respond_to do |format|
      format.turbo_stream if params[:last_post_id]
      format.html
    end
  end

  def toggle = respond_with_head(:created) { Post.find(params[:id]).toggle_bookmark_for_user }
end
