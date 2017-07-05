# frozen_string_literal: true
module EacRailsUtils
  require 'nested_form_fields'
  require 'ofx-parser'

  require 'eac_rails_utils/patches/model_attribute_required'
  require 'eac_rails_utils/patches/ofx_parser'
  require 'eac_rails_utils/rails/engine'
  require 'eac/cpf_validator'
  require 'eac/formatter_helper'
  require 'eac/common_form_helper/form_builder/association_select_field'
  require 'eac/common_form_helper/form_builder/common_text_fields'
  require 'eac/common_form_helper/form_builder/currency_field'
  require 'eac/common_form_helper/form_builder/date_field'
  require 'eac/common_form_helper/form_builder/fields_for'
  require 'eac/common_form_helper/form_builder/radio_select_field'
  require 'eac/common_form_helper/form_builder/searchable_association_field'
  require 'eac/common_form_helper/form_builder/year_month_field'
  require 'eac/common_form_helper/form_builder'
  require 'eac/common_form_helper'
  require 'eac/htmlbeautifier'
  require 'eac/inequality_queries'
  require 'eac/listable'
  require 'eac/menus_helper'
  require 'eac/menus_helper/bootstrap_gui_builder'
  require 'eac/menus_helper/data_builder'
  require 'eac/menus_helper/gui_builder'
  require 'eac/model'
  require 'eac/no_presence_validator'
  require 'eac/parsers/base'
  require 'eac/parsers/ofx'
  require 'eac/simple_cache'
  require 'eac/source_target_fixtures'

  ActionView::Base.send :include, Eac::CommonFormHelper
  ActionView::Base.send :include, Eac::FormatterHelper
  ActionView::Base.send :include, Eac::MenusHelper
end
