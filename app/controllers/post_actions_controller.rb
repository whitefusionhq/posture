# frozen_string_literal: true

class PostActionsController < ApplicationController
  def show
    posts = Post.where(id: params[:id].split(","))
    render(json: posts.map do |post|
      {
        post_id: post.id,
        bookmarked: post.post_actions.by_user(current_user).bookmark.exists?,
        favorited: post.post_actions.by_user(current_user).favorite.exists?,
      }
    end)
  end
end
