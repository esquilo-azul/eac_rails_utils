module EacRailsUtils
  module Models
    module TablelessAssociations
      class Railtie < ::Rails::Railtie #:nodoc:
        initializer 'activemodel-associations' do |_|
          EacRailsUtils::Models::TablelessAssociations::Hooks.init
        end
      end
    end
  end
end
