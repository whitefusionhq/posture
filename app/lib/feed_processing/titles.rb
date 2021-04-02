# frozen_string_literal: true

module FeedProcessing
  class Titles
    include ActionView::Helpers::SanitizeHelper

    def list(title, process_excerpt: false)
      if process_excerpt
        strip_tags HTML_Truncator.truncate(title, 14)
      else
        sanitize title, tags: %w(strong em b i u)
      end
    end
  end
end
