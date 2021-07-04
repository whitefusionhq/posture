class ActionsLoaderElement < ApplicationElement
  define %s:actions-loader:

  def actions_cache
    clear_timeout(@actions_debounce)
    @actions_cache = {} unless @actions_cache # rubocop:disable Style/OrAssignment

    @actions_cache
  end

  def load_actions_for_post(post)
    puts "saving post id #{post.post_id.to_i}"
    actions_cache[post.post_id.to_i] = post
    @actions_debounce = set_timeout 150 do
      self.load_cached_actions()
    end
  end

  async def load_cached_actions()
    response = await fetch "#{self.get_attribute("href")}/#{Object.keys(@actions_cache).join(",")}"
    actions = await response.json()

    actions.each do |data|
      post = @actions_cache[data["post_id"]]
      puts "loading post id #{data["post_id"]}"
      if data.bookmarked
        button = post.query_selector %s:sl-icon-button[name="bookmark"]:
        button.name = %s:bookmark-star:
        button.set_attribute :bookmarked, true
      end

      if data.favorited # rubocop:disable Style/Next
        button = post.query_selector %s:sl-icon-button[name="heart"]:
        button.name = %s:heart-fill:
        button.set_attribute :favorited, true
      end
    end

    @actions_cache = {}
  end
end
