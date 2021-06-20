# frozen_string_literal: true

class PostComponent < ApplicationComponent
  # rubocop:disable Metrics/ParameterLists
  def initialize(
    post:,
    subscription: nil,
    show_source: true,
    hide_hide_toggle: false,
    no_spacing: false
  )
    set_props do
      @source = @post.source
      @subscription ||= Current.user.subscription_for_source(@source) # could be nil
    end
  end
  # rubocop:enable Metrics/ParameterLists

  def hide_posts?
    !@hide_hide_toggle && @subscription&.hidden?
  end
end
