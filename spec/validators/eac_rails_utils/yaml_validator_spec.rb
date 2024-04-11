# frozen_string_literal: true

RSpec.describe(EacRailsUtils::YamlValidator) do
  include_examples 'active_model_attribute_validator', [
    nil,
    '--- STRING',
    "---\n{}",
    '--- []',
    "---\n- V1\n- V2",
    '',
    '         '
  ], [
    "---\n*STRING",
    "- V1\n- V2",
    'STRING'
  ]
end
