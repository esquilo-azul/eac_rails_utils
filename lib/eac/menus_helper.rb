module Eac
  module MenusHelper
    def dropdown_menu(entries)
      entries = DataBuilder.new(self).build(entries)
      return nil unless entries
      id = SecureRandom.hex(5)
      GuiBuilder.new(self).build(entries, id: id, class: 'jMenu') <<
        content_tag(:script) { raw("$(document).ready(function(){$('\##{id}').jMenu();});") }
    end

    def bootstrap_dropdown_menu(entries, options = {})
      entries = DataBuilder.new(self).build(entries)
      return nil unless entries
      BootstrapGuiBuilder.new(self, options).build(entries)
    end
  end
end
