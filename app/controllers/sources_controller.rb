# frozen_string_literal: true

class SourcesController < ApplicationController
  def show
    @source = Source.find_by_handle(params[:id].sub(%r!^@!, ""))

    # TODO: add pagination!
    @posts = @source.posts.order(published_at: :desc).limit(30)

    @recent_tags = current_user
      .source_subscriptions
      .select(:id)
      .map(&:tag_list)
      .flatten
      .uniq
      .sort

    respond_to do |format|
      format.turbo_stream if params[:last_post_id]
      format.html
    end
  end

  def update
    @source = Source.find(params[:id])
    authorize @source

    @source.update(secure_params)

    redirect_to source_path(@source.handle)
  end

  private

  def secure_params
    (params[:source] || params[:publication]).permit(:tag_list)
  end
end
