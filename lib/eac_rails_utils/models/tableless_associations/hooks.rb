# frozen_string_literal: true

module EacRailsUtils
  module Models
    module TablelessAssociations
      module Hooks
        def self.init
          ActiveSupport.on_load(:active_record) do
            ActiveRecord::Associations::AssociationScope.prepend(
              EacRailsUtils::Models::TablelessAssociations::AssociationScopeExtension
            )
          end
        end
      end
    end
  end
end
