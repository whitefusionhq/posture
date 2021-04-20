# frozen_string_literal: true

class PostActionsController < ApplicationController
  def show
    post = Post.find(params[:id])
    render json: {
      post_id: post.id,
      bookmarked: post.post_actions.by_user(current_user).bookmark.exists?,
      favorited: post.post_actions.by_user(current_user).favorite.exists?,
    }
  end
end
