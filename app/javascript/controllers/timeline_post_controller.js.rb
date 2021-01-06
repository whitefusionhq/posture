class TimelinePostController < ApplicationController
  def connect()
    super

    self.load_actions()

    i = self.element.querySelector %s:a[slot="image"] img:
    if i
      i.onload = ->() do
        # we don't want to blow up tiny images!
        i.parent_node.remove() if i.natural_width < 200 && i.natural_height < 200
      end
    end

    set_timeout 100 do
      self.element.class_list.add %s:load-complete:
    end
  end

  async def load_actions()
    await document.query_selector(%s:actions-loader:).load_actions_for_post(self.element)
  end

  def bookmark(event)
    button = event.target
    self.stimulate "Bookmark#toggle", button

    if event.target.name == :bookmark
      button.name = %s:bookmark-star:
      button.set_attribute :bookmarked, true
      raise_toast %s:bookmark-star:, "Bookmark Saved"
    else
      button.name = :bookmark
      button.remove_attribute :bookmarked
      raise_toast :bookmark, "Bookmark Removed", :danger
    end

    button.class_list.add("changed")
  end

  def favorite(event)
    button = event.target

    if event.target.name == :heart
      button.name = %s:heart-fill:
      button.set_attribute :favorited, true
      raise_toast %s:heart-fill:, "Added to Favorites"
    else
      button.name = :heart
      button.remove_attribute :favorited
      raise_toast :heart, "Removed from Favorites", :danger
    end

    button.class_list.add("changed")
  end

  def share(event)
    share_url = event.current_target.dataset.share_url
    if navigator.share
      navigator.share url: share_url
    else
      # fallback
      window.open share_url, :_blank
    end
  end

  def copy_link(event)
    alert "copying!"
  end
end

export default TimelinePostController
