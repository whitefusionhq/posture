import "./source_header_element.css"

class SourceHeaderElement < ApplicationElement
  target :number_of_posts_menus, ["sl-menu-item[data-num]"]
  target :toggle_button, "@togglebutton"
  define %s:source-header:, shadow_dom: false

  def toggle_posts(event)
    return if event.target != event.current_target
    return if @toggle_button.nil?

    self.get_attribute(%s:source-id:)       => source_id
    self.get_attribute(%s:subscription-id:) => subscription_id

    Daniel.post("/source_subscriptions/#{subscription_id}/toggle_visibility", {})

    self.parent_node.query_selector_all(%(timeline-post[source-id="#{source_id}"])).each do |node|
      node.hidden = !node.hidden
    end

    @toggle_button.name = @toggle_button.name == "dash-circle" ? "plus-circle" : "dash-circle"
  end

  async def change_number_of_posts(event)
    self.get_attribute(%s:source-id:)       => source_id
    self.get_attribute(%s:subscription-id:) => subscription_id
    number = event.target.dataset.num
    tposts = %(timeline-post[source-id="#{source_id}"])

    @number_of_posts_menus.each do |item|
      item.checked = false
    end
    event.target.checked = true

    resp = await Daniel.post("/source_subscriptions/#{subscription_id}/change_number_of_posts", {number: number})
    html = await resp.text()

    nodes_to_delete = self.parent_node.query_selector_all(tposts)
    self.parent_node.query_selector(tposts).insertAdjacentHTML("beforebegin", html)
    nodes_to_delete.each { |el| el.remove() }
  end

  def unsubscribe()
    self.get_attribute(%s:subscription-id:) => subscription_id
    Daniel.delete("/source_subscriptions/#{subscription_id}", {})

    Toaster.raise %s:slash-circle:, "Successfully Unsubscribed", type: :danger
  end
end
