# frozen_string_literal: true

class SourceSubscriptionsController < ApplicationController
  def create
    @source = Source.find params.dig(:source_subscription, :source_id)
    @source.toggle_subscription_for_user current_user

    redirect_to source_path(@source.handle)
  end

  def update
    @sub = current_user.source_subscriptions.find(params[:id])

    if params.dig(:source_subscription, :tag_list)
      @sub.update(tag_list: params[:source_subscription][:tag_list])
    end

    redirect_to source_path(@sub.source.handle)
  end

  def destroy
    @sub = current_user.source_subscriptions.find(params[:id])
    @sub.destroy

    redirect_to source_path(@sub.source.handle)
  end
end
