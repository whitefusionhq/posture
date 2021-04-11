# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :assign_current_user
    before_action :authenticate!
    helper_method :current_user
  end

  private

  def assign_current_user
    authenticated_user = locate_user_in_session_or_cookie
    return unless authenticated_user

    Current.user = authenticated_user
  end

  def authenticate!
    return if Current.user

    flash.notice = "Please sign in to access that feature"
    redirect_to login_url
  end

  def current_user = Current.user

  def locate_user_in_session_or_cookie
    User.find_by(id: session[:current_user_id]) ||
      User.find_by(id: cookies.encrypted[:remember_me])
  end

  def save_remember_me_token_for_user(user)
    cookies.encrypted.permanent[:remember_me] = { value: user.id, httponly: true }
  end
end
