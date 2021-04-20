# frozen_string_literal: true

class SourcesController < ApplicationController
  def show
    @source = Source.find_by_handle(params[:id].sub(%r!^@!, ""))

    @posts = @source.posts.order(published_at: :desc)

    respond_to do |format|
      format.turbo_stream if params[:last_post_id]
      format.html
    end
  end
end
