# frozen_string_literal: true

class SourceHeaderComponent < ApplicationComponent
  def initialize(
    source:,
    subscription:,
    hide_hide_toggle: false
  )
    set_props {}
  end

  def hide_posts?
    !@hide_hide_toggle && @subscription&.hidden?
  end
end
