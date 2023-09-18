# frozen_string_literal: true

module EacRailsUtils
  module Models
    module TablelessAssociations
      module OverrideMethods
        extend ActiveSupport::Concern

        module ClassMethods
          def generated_association_methods
            @generated_association_methods ||= begin
              mod = const_set(:GeneratedAssociationMethods, Module.new)
              include mod
              mod
            end
          end
          alias generated_feature_methods generated_association_methods \
          if ActiveRecord.version < Gem::Version.new('4.1')

          # override
          def dangerous_attribute_method?(_name)
            false
          end

          # dummy table name
          def pluralize_table_names
            to_s.pluralize
          end

          def clear_reflections_cache
            @__reflections = nil
          end

          def default_scopes
            []
          end

          protected

          def compute_type(type_name)
            if type_name.match(/^::/)
              # If the type is prefixed with a scope operator then we assume that
              # the type_name is an absolute reference.
              ActiveSupport::Dependencies.constantize(type_name)
            else
              compute_type_from_candidates(type_name)
            end
          end

          # Build a list of candidates to search for
          def compute_type_candidates(type_name)
            candidates = []
            name.scan(/::|$/) { candidates.unshift "#{$`}::#{type_name}" }
            candidates << type_name
          end

          def compute_type_from_candidates(type_name)
            compute_type_candidates(type_name).each do |candidate|
              constant = ActiveSupport::Dependencies.constantize(candidate)
              return constant if candidate == constant.to_s
              # We don't want to swallow NoMethodError < NameError errors
            rescue NoMethodError
              raise
            rescue NameError # rubocop:disable Lint/SuppressedException
            end

            raise NameError.new("uninitialized constant #{candidates.first}", candidates.first)
          end
        end

        # use by association accessor
        def association(name) #:nodoc:
          association = association_instance_get(name)

          if association.nil?
            association = association_by_reflection(name)
            association_instance_set(name, association)
          end

          association
        end

        def read_attribute(name)
          send(name)
        end
        alias _read_attribute read_attribute

        # dummy
        def new_record?
          false
        end

        private

        def association_by_reflection(name)
          reflection = self.class.reflect_on_association(name)
          if reflection.options[:active_model]
            ::ActiveRecord::Associations::HasManyForActiveModelAssociation.new(self, reflection)
          else
            reflection.association_class.new(self, reflection)
          end
        end

        # override
        def validate_collection_association(reflection)
          return unless (association = association_instance_get(reflection.name))

          if (records = associated_records_to_validate_or_save(
            association,
            false, reflection.options[:autosave]
          ))
            records.each { |record| association_valid?(reflection, record) }
          end
        end

        # use in Rails internal
        def association_instance_get(name)
          @association_cache[name]
        end

        # use in Rails internal
        def association_instance_set(name, association)
          @association_cache[name] = association
        end
      end
    end
  end
end
