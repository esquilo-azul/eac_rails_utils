# frozen_string_literal: true

module EacRailsUtils
  module Models
    module TablelessAssociations
      module Hooks
        class << self
          def init
            init_rails_5_2 if ::EacRailsUtils::Patches::Rails52.enabled?
          end

          def init_rails_5_2 # rubocop:disable Naming/VariableNumber
            rails_5_2_fix_activemodel_associations_methods
          end

          def rails_5_2_fix_activemodel_associations_methods
            %i[belongs_to has_many].each do |method|
              ::EacRailsUtils::Patches::Rails52::ActiveModelAssociationMethodFix.new(method)
            end
          end
        end
      end
    end
  end
end
