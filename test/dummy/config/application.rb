# frozen_string_literal: true

require File.expand_path('boot', __dir__)

require 'rails/all'

Bundler.require(*Rails.groups)
require 'eac_rails_utils'

module Dummy
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
  end
end
