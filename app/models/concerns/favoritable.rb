# frozen_string_literal: true

module Favoritable
  def toggle_favorite_for_user
    # TODO: support users!
    Rails.logger.warn "Can't save favorites without users!"

    if post_actions.favorite.exists?
      post_actions.favorite.delete_all
    else
      post_actions.favorite.create
    end
  end
end
