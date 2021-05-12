import "./source_header_element.css"

class SourceHeaderElement < ApplicationElement
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
end
