# frozen_string_literal: true

class BookmarkReflex < ApplicationReflex
  def toggle
    Post
      .find(element.dataset[:post_id])
      .toggle_bookmark_for_user

    morph :nothing
  end
end
