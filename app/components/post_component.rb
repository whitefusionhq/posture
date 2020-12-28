class PostComponent < ApplicationComponent
  include ApplicationHelper

  def initialize(post:, show_source: true)
    @post = post
    @source = post.source
    @show_source = show_source
  end
end
