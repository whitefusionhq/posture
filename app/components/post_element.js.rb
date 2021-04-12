class TimelinePostElement < ApplicationElement
  property :post_id, String, attribute: %s:post-id:
  property :source_id, String, attribute: %s:source-id:

  define %s:timeline-post:

  def connected_callback()
    super

    self.load_actions()

    i = self.query_selector :"a[slot=\"image\"] img"
    if i
      i.onload = -> do
        # we don't want to blow up tiny images!
        i.parent_node.remove() if i.natural_width < 200 && i.natural_height < 200
      end
    end

    set_timeout 100 do
      self.class_list.add %s:load-complete:
    end
  end

  async def load_actions()
    actions_loader = await self.context_element(%s:actions-loader:)
    await actions_loader.load_actions_for_post(self)
  end

  def bookmark(event)
    event.target => button
    Daniel.post("/bookmarks/toggle", id: self.post_id)

    if event.target.name == :bookmark
      button.name = %s:bookmark-star:
      button.set_attribute :bookmarked, true
      Toaster.raise %s:bookmark-star:, "Bookmark Saved"
    else
      button.name = :bookmark
      button.remove_attribute :bookmarked
      Toaster.raise :bookmark, "Bookmark Removed", type: :danger
    end

    button.class_list.add :changed
  end

  def favorite(event)
    event.target => button
    Daniel.post("/favorites/toggle", id: self.post_id)

    if event.target.name == :heart
      button.name = %s:heart-fill:
      button.set_attribute :favorited, true
      Toaster.raise %s:heart-fill:, "Added to Favorites"
    else
      button.name = :heart
      button.remove_attribute :favorited
      Toaster.raise :heart, "Removed from Favorites", type: :danger
    end

    button.class_list.add :changed
  end

  def share(event)
    event.current_target.dataset.share_url => share_url

    if navigator.share
      navigator.share url: share_url
    else
      # fallback
      window.open share_url, :_blank
    end
  end

  def copy_link(_event)
    alert "copying!"
  end
end
