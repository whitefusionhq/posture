# frozen_string_literal: true

class CleanOldPostsJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    Source.all.each do |source|
      posts = source.posts.includes(:post_actions).order(published_at: :desc)
      posts.to_a[20..]&.each do |post|
        next if post.post_actions.present?

        logger.info "Deleting Post: #{post.url}"
        post.delete
      end
    end
  end
end
