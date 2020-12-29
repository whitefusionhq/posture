# frozen_string_literal: true

class CheckFeedsJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    Publication.all.includes(:feeds).each do |publication|
      publication.feeds.active.each(&:import!)
    end
  end
end
