# frozen_string_literal: true

RSpec.describe(Numeric) do # rubocop:disable RSpec/RSpec/SpecFilePathFormat
  let(:instance) { 1234.567 }

  describe '#with_precision' do
    it { expect(instance.with_precision).to eq('1234.57') }
  end
end
