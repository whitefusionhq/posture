class ActionsLoaderElement < ApplicationElement
  define "actions-loader"

  async def load_actions_for_post(post)
    response = await fetch "/post_actions/#{post.dataset.post_id}"
    data = await response.json()

    if data.bookmarked
      button = post.query_selector %s:sl-icon-button[name="bookmark"]:
      button.name = %s:bookmark-star:
      button.set_attribute :bookmarked, true
    end
  end
end