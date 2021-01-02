class PostComponent < ApplicationComponent
  include ApplicationHelper

  def initialize(post:, show_source: true, hide_hide_toggle: false)
    @post = post
    @source = post.source
    @show_source = show_source
    @hide_hide_toggle = hide_hide_toggle
  end
end
