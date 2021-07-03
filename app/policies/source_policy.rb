# frozen_string_literal: true

class SourcePolicy < ApplicationPolicy
  def update? = user_is_admin
end
