# frozen_string_literal: true

class ApplicationComponent < ViewComponent::Base
  def set_props(&block) # rubocop:disable Naming/AccessorMethodName
    local_binding = block.binding
    local_binding.local_variables.each do |key|
      instance_variable_set :"@#{key}", local_binding.local_variable_get(key)
    end
    yield
  end
end
