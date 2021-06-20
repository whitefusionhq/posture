# frozen_string_literal: true

class ExploreController < ApplicationController
  def index
    source_tags = ActsAsTaggableOn::Tag
      .joins(:taggings)
      .includes(:taggings)
      .where(taggings: { taggable_type: "Source" })
      .order(:name)

    @tags = source_tags.map do |tag|
      { tag: tag, sources: tag.taggings.map(&:taggable).sort_by(&:title) }.with_dot_access
    end

    #    @publications = Publication.joins(:feeds).where(feeds: {active: true}).order(:title)
  end
end
