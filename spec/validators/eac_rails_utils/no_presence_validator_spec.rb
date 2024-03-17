# frozen_string_literal: true

RSpec.describe(EacRailsUtils::NoPresenceValidator) do
  include_examples 'active_model_attribute_validator', [
    nil,
    '',
    ' '
  ], [
    'abc',
    123,
    '*'
  ]
end
