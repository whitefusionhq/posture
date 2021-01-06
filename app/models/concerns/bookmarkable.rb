# frozen_string_literal: true

module Bookmarkable
  def toggle_bookmark_for_user
    # TODO: support users!
    Rails.logger.warn "Can't save bookmarks without users!"

    if post_actions.bookmark.exists?
      post_actions.bookmark.delete_all
    else
      post_actions.bookmark.create
    end
  end
end
