# frozen_string_literal: true

class PostComponent < ApplicationComponent
  def initialize(post:, show_source: true, hide_hide_toggle: false, no_spacing: false)
    set_props do
      @source = @post.source
    end
  end
end
