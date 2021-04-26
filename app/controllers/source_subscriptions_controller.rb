# frozen_string_literal: true

class SourceSubscriptionsController < ApplicationController
  def update
    @sub = SourceSubscription.find(params[:id])

    @sub.update(tag_list: params[:source_subscription][:tag_list])

    redirect_to source_path(@sub.source.handle)
  end
end
