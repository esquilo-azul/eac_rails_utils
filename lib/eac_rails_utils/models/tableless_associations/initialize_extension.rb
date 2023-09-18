# frozen_string_literal: true

module EacRailsUtils
  module Models
    module TablelessAssociations
      module InitializeExtension
        extend ActiveSupport::Concern

        included do
          prepend WithAssociationCache
        end

        module WithAssociationCache
          def initialize(*args)
            @association_cache = {}
            super
          end
        end
      end
    end
  end
end
