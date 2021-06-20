class TimelinePostElement < ApplicationElement
  property :post_id, String, attribute: %s:post-id:
  property :source_id, String, attribute: %s:source-id:

  target :post_image, "[slot=image] img"
  target :excerpt_links, ["post-excerpt a"]

  define %s:timeline-post:

  def connected_callback()
    super

    self.load_actions()

    set_timeout 100 do
      self.class_list.add %s:load-complete:

      self.add_blank_targets_to_links()

      if @post_image
        i = @post_image # cache query for speed
        i.onload = -> do
          # we don't want to blow up tiny images!
          i.parent_node.remove() if i.natural_width < 200 && i.natural_height < 200
        end
        i.onload() if i.complete # already loaded!
      end
    end
  end

  async def load_actions()
    actions_loader = await self.context_element(%s:actions-loader:)
    await actions_loader.load_actions_for_post(self)
  end

  def add_blank_targets_to_links() = @excerpt_links.each { |link| link.target = "_blank" }

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

  def copy_link(event) # rubocop:todo Metrics/AbcSize, Metrics/MethodLength
    event.current_target.dataset.share_url => share_url

    Elemental.create(:textarea) do |el|
      el.set_attribute :readonly, true
      el.value = share_url
      el.style.position = "absolute"
      el.style.left = "-9999px"
      el.style.font_size = "12pt"
      y_pos = window.page_y_offset || document.document_element.scroll_top
      el.style.top = "#{y_pos}px"
    end => faux_textarea

    document.body.append(faux_textarea)

    if navigator.user_agent.match?(%r{ipad|iphone}i)
      range = document.create_range()
      range.select_node_contents(faux_textarea)
      window.get_selection().add_range(range)
      faux_textarea.set_selection_range(0, share_url.length)
    else
      faux_textarea.select()
    end

    document.exec_command :copy

    faux_textarea.remove()

    Toaster.raise %s:link-45deg:, "Link Copied to Clipboard"
  end

  def report_issue()
    Toaster.raise :megaphone, "We're working on moderation capabilities. Stay tuned!"
  end
end
