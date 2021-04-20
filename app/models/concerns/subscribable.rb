# frozen_string_literal: true

module Subscribable
  def toggle_subscription_for_user(user = nil)
    Current.user => user unless user

    if subscriptions.exists?
      subscriptions.by_user(user).delete_all
    else
      subscriptions.create(user: user)
    end
  end
end
