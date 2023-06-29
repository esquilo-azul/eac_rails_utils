require "active_model"
require "active_record"
require "active_support"
require "eac_rails_utils/models/tableless_associations"
require "eac_rails_utils/models/tableless_associations/hooks"

# Load Railtie
begin
  require "rails"
rescue LoadError
end

if defined?(Rails)
  require "eac_rails_utils/models/tableless_associations/railtie"
end
