# frozen_string_literal: true

require 'eac_ruby_utils/require_sub'

module EacRailsUtils
  ::EacRubyUtils.require_sub __FILE__
  require_relative 'eac'

  require 'action_view/base'
  ActionView::Base.include Eac::CommonFormHelper
  ActionView::Base.include Eac::DataTableHelper
end
