# frozen_string_literal: true

require 'eac_rails_utils/menus/group'

module Rails
  class Application
    # @return [EacRailsUtils::Menus::Group]
    def root_menu
      @root_menu ||= ::EacRailsUtils::Menus::Group.new(:root, nil)
    end
  end
end
