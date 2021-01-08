# frozen_string_literal: true

class PostComponent < ApplicationComponent
  include ApplicationHelper

  def initialize(post:, show_source: true, hide_hide_toggle: false)
    set_props do
      @source = @post.source
    end
  end
end
