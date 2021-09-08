# frozen_string_literal: true

require 'activemodel/associations'
require 'eac_rails_utils/patches/rails_4'
require 'eac_rails_utils/patches/rails_5_2'

module ActiveModel
  module Associations
    module Hooks
      class << self
        def init
          init_rails_4 if ::EacRailsUtils::Patches::Rails4.enabled?
          init_rails_5_2 if ::EacRailsUtils::Patches::Rails52.enabled?
        end

        def init_rails_4
          ActiveSupport.on_load(:active_record) do
            ActiveRecord::Associations::AssociationScope.prepend(
              ::EacRailsUtils::Patches::Rails4::ActiveRecordAssociationsAssociationScope
            )
          end
        end

        def init_rails_5_2
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
