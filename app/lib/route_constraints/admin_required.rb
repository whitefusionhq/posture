# frozen_string_literal: true

module RouteConstraints
  class AdminRequiredConstraint
    include RouteConstraints::UserConstraint

    def matches?(request)
      user = current_user(request)
      user.present? && user.is_admin?
    end
  end
end
