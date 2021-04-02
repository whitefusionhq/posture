# frozen_string_literal: true

module RouteConstraints
  class UserConstraint
    def current_user(request)
      User.find_by_id(request.session[:user_id])
    end
  end
end
