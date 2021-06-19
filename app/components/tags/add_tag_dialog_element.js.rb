class AddTagDialogElement < ApplicationElement
  target :dialog,        "sl-dialog"
  target :recent_tags,   "sl-dialog sl-select"
  target :tag_input,     "sl-dialog sl-input"
  target :close_button,  %(sl-button[slot="footer"])
  target :emoji_picker,  "emoji-picker"
  target :emoji_preview, "emoji-preview"

  define %s:add-tag-dialog:, shadow_dom: false

  def connected_callback()
    super()

    @new_tags = ""

    set_timeout 0 do
      # Isn't working :(
      #      @dialog.add_event_listener %s:sl-initial-focus: do |event|
      #        event.prevent_default()
      #        @tag_input.focus(prevent_scroll: true)
      #      end
      @recent_tags.add_event_listener %s:sl-change: do |event|
        @new_tags = event.target.value
        self.save_and_close()
      end
      @tag_input.add_event_listener %s:sl-input: do |event|
        @new_tags = event.target.value
      end
      @emoji_picker.add_event_listener %s:emoji-click: do |event|
        @emoji_preview.text_content = event.detail.unicode
        event.target.closest("sl-dropdown").hide()
      end
    end
  end

  def show()
    @tag_input.value = ""
    @emoji_preview.text_content = "#"
    @dialog.show()
  end

  def save_and_close()
    if @new_tags.blank?
      Toaster.raise %s:exclamation-octagon:, "Please enter a tag", type: :danger
      return
    end

    added_tag = @new_tags
    added_tag += " #{@emoji_preview.text_content}" if @emoji_preview.text_content != "#"

    Elemental.query("tag-list").tap do |list|
      list.save_list(
        list.list_input.value + ",#{added_tag}"
      )
    end

    @dialog.hide()
    @new_tags = ""
  end
end
