# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate!

  def new = nil

  def create
    if user = User.find_by_email(params[:email])&.authenticate(params[:password]) # rubocop:disable Lint/AssignmentInCondition
      session[:current_user_id] = user.id
      save_remember_me_token_for_user(user)
      flash[:reload_navbars] = true
      redirect_to "/"
    else
      flash.now[:alert] = "Account not found or incorrect password"
      render_flash
    end
  end

  def destroy = reset_session_and_redirect_to("/")
end
