# frozen_string_literal: true

RSpec.describe(EacRailsUtils::UriValidator) do
  include_examples 'active_model_attribute_validator', [
    nil,
    'scheme:path',
    'https://example.org'
  ], [
    'scheme',
    ':'
  ]
end
