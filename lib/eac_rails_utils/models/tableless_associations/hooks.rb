# frozen_string_literal: true

module EacRailsUtils
  module Models
    module TablelessAssociations
      module Hooks
        def self.init
          ActiveSupport.on_load(:active_record) do
            require 'eac_rails_utils/models/tableless_associations/association_scope_extension'
            ActiveRecord::Associations::AssociationScope.prepend(
              EacRailsUtils::Models::TablelessAssociations::AssociationScopeExtension
            )
          end
        end
      end
    end
  end
end
