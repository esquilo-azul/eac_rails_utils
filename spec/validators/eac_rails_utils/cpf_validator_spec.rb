# frozen_string_literal: true

::RSpec.describe(::EacRailsUtils::CpfValidator) do
  include_examples 'active_model_attribute_validator', [
    '85630275305',
    '66244374487',
    nil
  ], [
    '',
    ' ',
    'abc',
    '856.302.753-05',
    '662.443.744-87',
    '85630275304'
  ]
end
