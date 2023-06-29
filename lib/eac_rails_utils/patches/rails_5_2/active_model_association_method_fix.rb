# frozen_string_literal: true

require 'activemodel/associations'
require 'eac_ruby_utils/core_ext'

module EacRailsUtils
  module Patches
    module Rails52
      class ActiveModelAssociationMethodFix
        common_constructor :method_name do
          perform
        end

        def original_method_new_name
          "original_#{method_name}".to_sym
        end

        private

        def the_module
          ::EacRailsUtils::Models::TablelessAssociations::ClassMethods
        end

        def perform
          patch = self
          the_module.class_eval do
            alias_method patch.original_method_new_name, patch.method_name
            remove_method patch.method_name

            define_method patch.method_name do |name, scope = nil, **options, &extension|
              send(patch.original_method_new_name, name, scope, options, &extension)
            end
          end
        end
      end
    end
  end
end
