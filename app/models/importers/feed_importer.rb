# frozen_string_literal: true

require "feed_processing/content_truncation"

module Importers
  class FeedImporter
    CHECK_INTERVAL = 10

    def initialize(record)
      @feed_record = record
    end

    # rubocop:todo Metrics/PerceivedComplexity
    # rubocop:todo Metrics/MethodLength
    # rubocop:todo Metrics/AbcSize
    def run_import(force = false) # rubocop:todo Metrics/CyclomaticComplexity
      # NOTE: this should be run from a worker, ideally

      return false if should_cancel_import? && !force

      feed_data = load_feed_data
      begin
        feed = Feedjira.parse(feed_data)
      rescue Feedjira::NoParserAvailable
        Rails.logger.warn "*** ERROR: unable to parse #{url} : ID (#{id})"
        return false
      end
      update_column(:last_checked_at, DateTime.current)

      feed.entries[0...20].each do |entry| # rubocop:todo Metrics/BlockLength
        # TODO: check out Pry (or ByeBug?) for debugging!

        next if entry.published.nil? # weird format, let's skip

        html = if entry.summary.present? && !bad_summary?
                 entry.summary
               else
                 entry.content
               end

        # Look for an image thumbnail
        htmldom = Nokogiri.parse("<html>#{html}</html>")
        imgtag = htmldom.at_css("img")
        thumbnail_url = imgtag ? imgtag["src"] : nil

        # Process incoming text
        truncated_to_word_count = if entry.title.blank?
                                    # allow longer titleless posts
                                    875
                                  else
                                    80
                                  end
        processor = PostProcessing::ContentTruncation.new
        entry_text = processor.truncate_html(html, truncated_to_word_count)

        # Create the new post record
        if posts.where(url: entry.url).count.zero?
          new_post = posts.create(
            data_store: publication,
            title: entry.title,
            url: entry.url,
            excerpt: entry_text,
            published_at: entry.published
          )
          new_post.import_thumbnail!(thumbnail_url) if thumbnail_url
        elsif force
          # If forcing, update a post if the feed fixed something and updated it
          post = posts.where(url: entry.url).first
          post.update_attributes(title: entry.title, excerpt: entry_text)
        end
      end

      true
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength
    # rubocop:enable Metrics/PerceivedComplexity

    private

    def load_feed_data
      # TODO: warn admins if redirects are happening?
      conn = Faraday.new do |f|
        f.use FaradayMiddleware::FollowRedirects, limit: 2
        f.adapter Faraday.default_adapter
      end
      @raw_feed_data ||= conn.get(url).body
    end

    def should_cancel_import?
      !@feed_record.active || (
        @feed_record.last_checked_at || (CHECK_INTERVAL + 1).minutes.ago
      ) > CHECK_INTERVAL.minutes.ago
    end
  end
end
