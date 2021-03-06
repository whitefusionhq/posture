# frozen_string_literal: true

module FeedProcessing
  class ContentTruncation
    attr_reader :content

    def initialize(content)
      @content = content
    end

    def truncate(word_count = 80)
      return "" if content.blank?

      white_list_sanitizer = Rails::Html::WhiteListSanitizer.new

      # totally remove all traces of script or style tags
      scrubber = Loofah::Scrubber.new do |node|
        if node.name.in? %w(script style)
          node.remove
          Loofah::Scrubber::STOP # don't bother with the rest of the subtree
        end
      end

      content
        .then { |str| Loofah.fragment(str).scrub!(scrubber).to_s }
        .then { |str| str.gsub("</p>", "</p> ") }
        .then { |str| white_list_sanitizer.sanitize(str, tags: %w(a strong em b i u)) }
        .then { |str| HTML_Truncator.truncate(str, word_count) }
    end
  end
end
