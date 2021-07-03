# frozen_string_literal: true

class AccountController < ApplicationController
  # admin dashboard
  def admin
    @sources = Source.order(:title)
  end
end
