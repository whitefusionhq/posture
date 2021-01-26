class ActionsLoaderElement < ApplicationElement
  define %s:actions-loader:

  async def load_actions_for_post(post)
    response = await fetch "#{self.get_attribute("href")}/#{post.post_id}"
    data = await response.json()

    if data.bookmarked
      button = post.query_selector %s:sl-icon-button[name="bookmark"]:
      button.name = %s:bookmark-star:
      button.set_attribute :bookmarked, true
    end

    if data.favorited
      button = post.query_selector %s:sl-icon-button[name="heart"]:
      button.name = %s:heart-fill:
      button.set_attribute :favorited, true
    end
  end
end
