# frozen_string_literal: true

require 'activemodel/associations'
require 'eac_rails_utils/patches/rails_4'

module ActiveModel
  module Associations
    module Hooks
      class << self
        def init
          init_rails_4 if ::EacRailsUtils::Patches::Rails4.enabled?
        end

        def init_rails_4
          ActiveSupport.on_load(:active_record) do
            ActiveRecord::Associations::AssociationScope.prepend(
              ::EacRailsUtils::Patches::Rails4::ActiveModelAssociations::ScopeExtensionPatch
            )
          end
        end
      end
    end
  end
end
