# frozen_string_literal: true

class ReadMoreComponent < ApplicationComponent
  include ApplicationHelper

  def initialize(id:, url:)
    set_props {}
  end
end
