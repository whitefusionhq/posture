class TimelinePostElement < ApplicationElement
  self.properties = {
    post_id: { attribute: %s:post-id:, type: String },
    source_id: { attribute: %s:source-id:, type: String },
  }

  define %s:timeline-post:

  def connected_callback()
    super

    self.load_actions()

    i = self.querySelector %s:a[slot="image"] img:
    if i
      i.onload = -> do
        # we don't want to blow up tiny images!
        i.parent_node.remove() if i.natural_width < 200 && i.natural_height < 200
      end
    end

    self.dataset.controller = %s:post-actions: # load up Stimulus controller

    set_timeout 100 do
      self.class_list.add %s:load-complete:
    end
  end

  async def load_actions()
    actions_loader = await self.context_element(%s:actions-loader:)
    await actions_loader.load_actions_for_post(self)
  end
end
