# frozen_string_literal: true

module EacRailsUtils
  module Models
    class Tableless
      include ActiveModel::Model
      include Virtus.model
      include EacRailsUtils::Models::TablelessAssociations

      def initialize(values = {})
        super(build_attributes(values))
      end

      def save!
        save || raise("#{self.class}.save failed: #{errors.messages}")
      end

      require_sub __FILE__, require_mode: :kernel, include_modules: :include
    end
  end
end
