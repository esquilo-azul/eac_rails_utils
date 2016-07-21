module EacRailsUtils
  require 'eac_rails_utils/rails/engine'
  require 'eac/formatter_helper'
  require 'eac/htmlbeautifier'
  require 'eac/model'
  require 'eac/simple_cache'
  require 'eac/source_target_fixtures'

  ActionView::Base.send :include, Eac::FormatterHelper
end
