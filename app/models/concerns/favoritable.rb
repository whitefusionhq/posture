# frozen_string_literal: true

module Favoritable
  def toggle_favorite_for_user(user = nil)
    Current.user => user unless user

    if post_actions.by_user(user).favorite.exists?
      post_actions.by_user(user).favorite.delete_all
    else
      post_actions.favorite.create(user: user)
    end
  end
end
