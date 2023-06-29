module EacRailsUtils::Models::TablelessAssociations
  module Hooks
    def self.init
      ActiveSupport.on_load(:active_record) do
        require 'eac_rails_utils/models/tableless_associations/association_scope_extension'
        ActiveRecord::Associations::AssociationScope.send(:prepend, EacRailsUtils::Models::TablelessAssociations::AssociationScopeExtension)
      end
    end
  end
end