# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  # make this a real admin role!
  def admin? = user.email == "jared@whitefusion.studio"
end
