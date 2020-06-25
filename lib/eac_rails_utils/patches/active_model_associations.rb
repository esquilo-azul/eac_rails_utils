# frozen_string_literal: true

require 'active_model/associations/hooks'
require 'activemodel/associations'

module EacRailsUtils
  module Patches
    module ActiveModelAssociations
      module ScopeExtensionPatch
        def add_constraints(scope, owner, association_klass, *extra_args)
          if extra_args.any?
            refl = extra_args.first
            if refl.options[:active_model]
              target_ids = refl.options[:target_ids]
              return scope.where(id: owner[target_ids])
            end
          end

          super
        end
      end
    end
  end
end

module ActiveModel
  module Associations
    module Hooks
      def self.init
        ActiveSupport.on_load(:active_record) do
          ActiveRecord::Associations::AssociationScope.prepend(
            ::EacRailsUtils::Patches::ActiveModelAssociations::ScopeExtensionPatch
          )
        end
      end
    end
  end
end
