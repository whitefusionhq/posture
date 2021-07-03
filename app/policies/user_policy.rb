# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def admin? = user_is_admin
end
