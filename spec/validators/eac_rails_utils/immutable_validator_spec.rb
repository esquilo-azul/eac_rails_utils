# frozen_string_literal: true

::RSpec.describe(::EacRailsUtils::ImmutableValidator) do
  let(:model) { ::ImmutableStub }

  context 'when record is created' do
    let(:record) { model.new }

    before do
      record.immutable_attr = 'a value'
      record.save
    end

    it { expect(record).to be_valid }
    it { expect(record.errors[:immutable_attr]).to eq([]) }

    context 'when record is updated' do
      before do
        record.immutable_attr = 'another value value'
        record.save
      end

      it { expect(record).not_to be_valid }
      it { expect(record.errors[:immutable_attr]).not_to eq([]) }
    end
  end
end
