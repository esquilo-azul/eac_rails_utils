module EacRailsUtils
  require 'eac_rails_utils/rails/engine'
  require 'eac/cpf_validator'
  require 'eac/formatter_helper'
  require 'eac/htmlbeautifier'
  require 'eac/menus_helper'
  require 'eac/menus_helper/bootstrap_gui_builder'
  require 'eac/menus_helper/data_builder'
  require 'eac/menus_helper/gui_builder'
  require 'eac/model'
  require 'eac/simple_cache'
  require 'eac/source_target_fixtures'

  ActionView::Base.send :include, Eac::FormatterHelper
  ActionView::Base.send :include, Eac::MenusHelper
end
