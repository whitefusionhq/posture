class TimelinePostController < Controller
  def connect()
    img = self.element.querySelector(%(a[slot="image"] img))
    if img
      img.onload = ->() do
        if img.natural_width < 200 && img.natural_height < 200
          img.parent_node.remove() # we don't want to blow up tiny images!
        end
      end
    end

    set_timeout 0 do
      self.element.class_list.add("load-complete")
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
