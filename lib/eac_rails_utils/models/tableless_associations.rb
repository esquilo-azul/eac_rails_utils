# frozen_string_literal: true

require 'eac_rails_utils/models/tableless_associations/initialize_extension'
require 'eac_rails_utils/models/tableless_associations/active_record_reflection'
require 'eac_rails_utils/models/tableless_associations/autosave_association'
require 'eac_rails_utils/models/tableless_associations/override_methods'
require 'eac_rails_utils/models/tableless_associations/has_many_for_active_model'
require 'active_record/associations/has_many_for_active_model_association'
require 'active_support/core_ext/module'

module EacRailsUtils
  module Models
    module TablelessAssociations
      extend ActiveSupport::Concern

      include InitializeExtension
      include AutosaveAssociation
      include ActiveRecordReflection
      include OverrideMethods

      included do
        mattr_accessor :belongs_to_required_by_default, instance_accessor: false
      end

      module ClassMethods
        # define association like ActiveRecord
        def belongs_to(name, scope = nil, **options)
          reflection = ActiveRecord::Associations::Builder::BelongsTo
                         .build(self, name, scope, options)
          ActiveRecord::Reflection.add_reflection self, name, reflection
        end

        # define association like ActiveRecord
        def has_many(name, scope = nil, **options, &extension) # rubocop:disable Naming/PredicateName, Metrics/MethodLength
          options.reverse_merge!(active_model: true, target_ids: "#{name.to_s.singularize}_ids")
          if scope.is_a?(Hash)
            options.merge!(scope)
            scope = nil
          end

          reflection = EacRailsUtils::Models::TablelessAssociations::HasManyForActiveModel
                         .build(self, name, scope, options, &extension)
          ActiveRecord::Reflection.add_reflection self, name, reflection

          mixin = generated_association_methods
          mixin.class_eval <<-CODE, __FILE__, __LINE__ + 1 # rubocop:disable Style/DocumentDynamicEvalDefinition
          def #{options[:target_ids]}=(other_ids)
            @#{options[:target_ids]} = other_ids
            association(:#{name}).reset
            association(:#{name}).reset_scope
            @#{options[:target_ids]}
          end
          CODE
        end
      end
    end
  end
end
