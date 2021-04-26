# frozen_string_literal: true

class SourcesController < ApplicationController
  def show
    @source = Source.find_by_handle(params[:id].sub(%r!^@!, ""))

    # TODO: add pagination!
    @posts = @source.posts.order(published_at: :desc).limit(30)

    respond_to do |format|
      format.turbo_stream if params[:last_post_id]
      format.html
    end
  end
end
