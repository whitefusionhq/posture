# frozen_string_literal: true

class SourceSubscriptionsController < ApplicationController
  def create
    @source = Source.find params.dig(:source_subscription, :source_id)
    @source.toggle_subscription_for_user current_user

    redirect_to source_path(@source.handle)
  end

  def update
    if params.dig(:source_subscription, :tag_list)
      user_sub.update(tag_list: params[:source_subscription][:tag_list])
    end

    redirect_to source_path(user_sub.source.handle)
  end

  def destroy = respond_with_redirect(source_path(user_sub_source.handle)) { user_sub.destroy }

  def toggle_visibility = respond_with_head(:created) { user_sub.toggle_visibility! }

  private

  # @return [SourceSubscription]
  def user_sub = @user_sub ||= current_user.source_subscriptions.find(params[:id])

  # @return [Source]
  def user_sub_source = user_sub.source
end
