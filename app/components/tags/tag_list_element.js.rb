class TagListElement < ApplicationElement
  target :form, :form
  target :list_input, %(input[name="source_subscription[tag_list]"])
  target :submit_button, %(form input[type="submit"])
  define %s:tag-list:, shadow_dom: false

  attr_reader :list_input

  def connected_callback()
    super()

    if self.get_attribute(:editable)
      self.add_event_listener %s:sl-clear: do |event|
        tag_name = event.target.text_content.sub("#", "").strip
        tags = @list_input.value.split(",")
        tags = tags.select { |tag| tag != tag_name } # rubocop:disable Style/InverseMethods
        save_list tags.join(",")
      end
    end
  end

  def add_tag()
    dialog.show()
  end

  def save_list(new_value)
    @list_input.value = new_value
    @submit_button.click()
  end

  def dialog
    Elemental.query("body > add-tag-dialog")
  end
end
