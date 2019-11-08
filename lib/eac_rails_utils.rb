# frozen_string_literal: true
require 'active_support/dependencies'

module EacRailsUtils
  require 'activemodel/associations'
  require 'nested_form_fields'
  require 'ofx-parser'
  require 'virtus'

  require 'eac_rails_utils/patches/action_controller_base'
  require 'eac_rails_utils/patches/model_attribute_required'
  require 'eac_rails_utils/patches/ofx_parser'
  require 'eac_rails_utils/engine'
  require 'eac_rails_utils/tableless_model'
  require 'eac/cpf_validator'
  require 'eac/common_form_helper/form_builder/association_select_field'
  require 'eac/common_form_helper/form_builder/common_text_fields'
  require 'eac/common_form_helper/form_builder/currency_field'
  require 'eac/common_form_helper/form_builder/date_field'
  require 'eac/common_form_helper/form_builder/fields_for'
  require 'eac/common_form_helper/form_builder/file_field'
  require 'eac/common_form_helper/form_builder/radio_select_field'
  require 'eac/common_form_helper/form_builder/searchable_association_field'
  require 'eac/common_form_helper/form_builder/select_field'
  require 'eac/common_form_helper/form_builder/time_field'
  require 'eac/common_form_helper/form_builder/year_month_field'
  require 'eac/common_form_helper/form_builder'
  require 'eac/common_form_helper'
  require_dependency 'eac/data_table_helper'
  require 'eac/htmlbeautifier'
  require 'eac/inequality_queries'
  require 'eac/menus_helper'
  require 'eac/menus_helper/bootstrap_gui_builder'
  require 'eac/menus_helper/data_builder'
  require 'eac/menus_helper/gui_builder'
  require 'eac/model'
  require 'eac/no_presence_validator'
  require 'eac/parsers/files_test'
  require 'eac/source_target_fixtures'
  require 'eac/test_utils'

  ActionView::Base.send :include, Eac::CommonFormHelper
  ActionView::Base.send :include, Eac::DataTableHelper
  ActionView::Base.send :include, Eac::MenusHelper
end
