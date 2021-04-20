# frozen_string_literal: true

module Importers
  class FeedImporter
    CHECK_INTERVAL = 10

    attr_accessor :feed_record, :raw_feed_data

    def initialize(record)
      @feed_record = record
    end

    # rubocop:todo Metrics/PerceivedComplexity
    # rubocop:todo Metrics/MethodLength
    # rubocop:todo Metrics/AbcSize
    # rubocop:todo Metrics/CyclomaticComplexity
    def import!(force: false)
      # NOTE: this should be run from a worker, ideally

      return false if should_cancel_import? && !force

      feed_data = load_feed_data
      begin
        feed = Feedjira.parse(feed_data)
      rescue Feedjira::NoParserAvailable
        Rails.logger.warn "*** ERROR: unable to parse #{feed_record.url} : ID (#{feed_record.id})"
        return false
      end
      feed_record.update_column(:last_checked_at, DateTime.current)

      source_update_date = nil

      feed.entries[0...20].each do |entry| # rubocop:todo Metrics/BlockLength
        next if entry.published.nil? # weird format, let's skip

        html = if entry.summary.present? && !feed_record.bad_summary?
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
        processor = FeedProcessing::ContentTruncation.new(html)
        entry_text = processor.truncate(truncated_to_word_count)

        # Create the new post record
        if feed_record.posts.where(url: entry.url).count.zero?
          new_post = feed_record.posts.create(
            source: feed_record.publication,
            title: entry.title,
            url: entry.url,
            excerpt: entry_text,
            published_at: entry.published
          )
          unless !source_update_date.nil? && entry.published < source_update_date
            source_update_date = entry.published
          end
          new_post.import_thumbnail!(thumbnail_url) if thumbnail_url
        elsif force
          # If forcing, update a post if the feed fixed something and updated it
          post = feed_record.posts.where(url: entry.url).first
          post.update(title: entry.title, excerpt: entry_text)
        end
      end

      if source_update_date
        feed_record.publication.update_column(:latest_post_at, source_update_date)
      end

      true
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength
    # rubocop:enable Metrics/PerceivedComplexity
    # rubocop:enable Metrics/CyclomaticComplexity

    private

    def load_feed_data
      # TODO: warn admins if redirects are happening?
      conn = Faraday.new do |f|
        f.use FaradayMiddleware::FollowRedirects, limit: 3
        f.adapter Faraday.default_adapter
      end
      @raw_feed_data ||= conn.get(feed_record.url).body
    rescue FaradayMiddleware::RedirectLimitReached
      Rails.logger.warn "*** ERROR: unable to parse #{feed_record.url} : ID (#{feed_record.id})"
    end

    def should_cancel_import?
      !feed_record.active || (
        feed_record.last_checked_at || (CHECK_INTERVAL + 1).minutes.ago
      ) > CHECK_INTERVAL.minutes.ago
    end
  end
end
