# frozen_string_literal: true

require 'eac_rails_utils/patches/active_model_associations'
require 'virtus'

module EacRailsUtils
  module Models
    class Tableless
      include ActiveModel::Model
      include Virtus.model
      include ActiveModel::Associations

      class << self
        def columns
          attribute_set.each.to_a
        end

        def columns_names
          columns.map(&:name)
        end
      end

      def initialize(values = {})
        super(build_attributes(values))
      end

      def attributes=(values)
        super(build_attributes(values))
      end

      # need hash like accessor, used internal Rails
      def [](attr)
        send(attr)
      end

      # need hash like accessor, used internal Rails
      def []=(attr, value)
        send("#{attr}=", value)
      end

      def save!
        save || raise("#{self.class}.save failed: #{errors.messages}")
      end

      private

      def build_attributes(values)
        ::EacRailsUtils::Models::Tableless::BuildAttributes.new(self.class, values).to_attributes
      end

      require_sub __FILE__
    end
  end
end
