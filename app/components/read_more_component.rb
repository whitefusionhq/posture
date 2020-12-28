# frozen_string_literal: true

class ReadMoreComponent < ApplicationComponent
  include ApplicationHelper

  def initialize(id:, url:)
    @id = id
    @url = url
  end
end
