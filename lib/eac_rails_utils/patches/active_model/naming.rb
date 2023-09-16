# frozen_string_literal: true

require 'active_model/naming'

module ActiveModel
  module Naming
    # @return [String]
    def plural_name
      model_name.human(count: 2)
    end

    # @return [String]
    def singular_name
      model_name.human(count: 1)
    end
  end
end
