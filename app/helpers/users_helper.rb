# frozen_string_literal: true

module UsersHelper
  def update?(model) = policy(model).update?

  def admin?(model) = model && policy(model).admin?
end
