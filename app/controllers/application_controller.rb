# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Authentication
  include Pundit
  #  after_action :verify_authorized # check this out: https://github.com/varvet/pundit#conditional-verification

  private

  # Hat tip: https://bramjetten.dev/articles/flash-messages-with-hotwire-and-turbo-streams
  def render_flash = render(turbo_stream: turbo_stream.update("flash", partial: "flashes"))

  def reset_session_and_redirect_to(path)
    reset_session
    delete_remember_me_token
    flash[:reload_navbars] = true
    redirect_to path
  end

  def respond_with_redirect(path)
    yield

    redirect_to path
  end

  def respond_with_head(status, options = {})
    yield

    head status, options
  end
end
