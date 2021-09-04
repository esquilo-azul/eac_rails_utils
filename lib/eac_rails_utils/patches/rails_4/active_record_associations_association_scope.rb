# frozen_string_literal: true

require 'activemodel/associations'

module EacRailsUtils
  module Patches
    module Rails4
      module ActiveRecordAssociationsAssociationScope
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
