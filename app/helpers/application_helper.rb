# frozen_string_literal: true

module ApplicationHelper
  def sanitize_tags(input, tags)
    sanitize(input, tags: tags)
  end
end
