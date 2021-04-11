# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate!
  end

  private

  def authenticate!
    if authenticated_user = locate_user_in_session_or_cookie # rubocop:disable Lint/AssignmentInCondition
      Current.user = authenticated_user
    else
      #      flash.notice = "authenticate"
      #      redirect_to new_session_url
    end
  end

  def current_user
    Current.user
  end

  def locate_user_in_session_or_cookie
    User.find_by(id: session[:current_user_id]) ||
      User.find_by(id: cookies.encrypted[:remember_me])
  end

  def save_remember_me_token_for_user(user)
    cookies.encrypted.permanent[:remember_me] = { value: user.id, httponly: true }
  end
end
