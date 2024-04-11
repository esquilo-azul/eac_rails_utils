require 'active_model' # rubocop:disable Style/FrozenStringLiteralComment
require 'active_record'
require 'active_support'
require 'eac_rails_utils/models/tableless_associations'
require 'eac_rails_utils/models/tableless_associations/hooks'

# Load Railtie
begin
  require 'rails'
rescue LoadError # rubocop:disable Lint/SuppressedException
end

require 'eac_rails_utils/models/tableless_associations/railtie' if defined?(Rails)
