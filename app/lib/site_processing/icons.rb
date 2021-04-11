# frozen_string_literal: true

module SiteProcessing
  class Icons
    def initialize(htmldom, base_url)
      @htmldom = htmldom
      @base_url = base_url
      @abs_url = AbsoluteURL.new @base_url
    end

    def touch_icon
      touch_icons = @htmldom.css(
        'link[rel="apple-touch-icon"], link[rel="apple-touch-icon-precomposed"]'
      )
      touch_sizes = {}
      touch_icons.each do |touch_icon|
        if touch_icon["sizes"]
          touch_sizes[touch_icon["sizes"].to_i] = touch_icon["href"]
        else
          touch_sizes[0] = touch_icon["href"]
        end
      end

      # pick the largest one
      largest_size = touch_sizes.keys.max
      @abs_url.resolve touch_sizes[largest_size]
    end

    def favicon
      favicon = @htmldom.at_css('link[rel="icon"]') || @htmldom.at_css('link[rel="shortcut icon"]')
      return unless favicon

      favicon = favicon["href"]
      @abs_url.resolve favicon
    end

    def choose_best_icon
      touch_icon || favicon
    end
  end
end
