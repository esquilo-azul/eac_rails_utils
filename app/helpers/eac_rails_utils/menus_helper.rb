# frozen_string_literal: true

require 'eac_ruby_utils/require_sub'

module EacRailsUtils
  module MenusHelper
    ::EacRubyUtils.require_sub __FILE__

    def dropdown_menu(entries)
      entries = DataBuilder.new(self).build(entries)
      return nil unless entries

      id = SecureRandom.hex(5)
      GuiBuilder.new(self).build(entries, id: id, class: 'jMenu') <<
        javascript_tag("$(document).ready(function(){$('\##{id}').jMenu();});")
    end

    def bootstrap_dropdown_menu(entries, options = {})
      entries = DataBuilder.new(self).build(entries)
      return nil unless entries

      BootstrapGuiBuilder.new(self, options).build(entries)
    end
  end
end
