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
    redirect_to path
  end
end
