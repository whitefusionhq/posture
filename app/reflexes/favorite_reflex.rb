# frozen_string_literal: true

class FavoriteReflex < ApplicationReflex
  def toggle
    Post
      .find(element.dataset[:post_id])
      .toggle_favorite_for_user

    morph :nothing
  end
end
