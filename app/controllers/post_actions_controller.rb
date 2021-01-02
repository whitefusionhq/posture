# frozen_string_literal: true

class PostActionsController < ApplicationController
  def show
    post = Post.find(params[:id])
    render json: {
      post_id: post.id,
      bookmarked: post.post_actions.bookmark.exists?,
    }
  end
end
