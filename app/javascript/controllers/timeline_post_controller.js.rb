class TimelinePostController < ApplicationController
  def connect()
    super

    i = self.element.querySelector(%(a[slot="image"] img))
    if i
      i.onload = ->() do
        # we don't want to blow up tiny images!
        i.parent_node.remove() if i.natural_width < 200 && i.natural_height < 200
      end
    end

    set_timeout 100 do
      self.element.class_list.add("load-complete")
    end
  end

  def bookmark(event)
    button = event.target
    if event.target.name == :bookmark
      self.stimulate "Bookmark#toggle", button
      button.name = :'bookmark-star'
      button.set_attribute :bookmarked, true
      raise_toast "Bookmark Saved"
    else
      button.name = :bookmark
      button.remove_attribute :bookmarked
      raise_toast "Bookmark Removed", :danger
    end
  end

  def share(event)
    share_url = event.current_target.dataset.share_url
    if navigator.share
      navigator.share(url: share_url)
    else
      # fallback
      window.open share_url, "_blank"
    end
  end

  def copy_link(event)
    alert("copying!")
  end
end

export default TimelinePostController
