class PostComponent < ApplicationComponent
  include ApplicationHelper

  def initialize(post:, show_source: true)
    @post = post
    @source = post.source
    @show_source = show_source

    # TODO: get real data!
    @bookmarked = [1,2,3].sample == 1
  end
end
