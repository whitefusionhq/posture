# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Authentication
  include Pundit
  #  after_action :verify_authorized # check this out: https://github.com/varvet/pundit#conditional-verification
end
