# frozen_string_literal: true

module Bookmarkable
  def toggle_bookmark_for_user(user = nil)
    Current.user => user unless user

    if post_actions.by_user(user).bookmark.exists?
      post_actions.by_user(user).bookmark.delete_all
    else
      post_actions.bookmark.create(user: user)
    end
  end
end
