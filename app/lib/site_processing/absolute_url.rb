# frozen_string_literal: true

module SiteProcessing
  class AbsoluteUrl
    def initialize(base_url)
      @base_url = base_url
    end

    def resolve(url)
      return nil if url.nil?

      if url.starts_with?("//")
        scheme = @base_url.match(%r!https?://!)[0].sub("//", "")
        "#{scheme}#{url}"
      elsif !url.starts_with?("http")
        if url.starts_with?("/")
          scheme, _sep, domain = @base_url.split("/")

          "#{scheme}//#{domain}#{url}"
        else
          "#{@base_url}/#{url}"
        end
      else
        url
      end
    end
  end
end
