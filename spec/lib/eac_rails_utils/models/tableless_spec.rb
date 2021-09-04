# frozen_string_literal: true

RSpec.describe(::EacRailsUtils::Models::Tableless) do
  let(:model) { StubbedTablelessModel }
  let(:record) do
    model.new('tempo(1i)' => '9', 'tempo(2i)' => '10', 'tempo(3i)' => '11',
              'tempo(4i)' => '12', 'tempo(5i)' => '13', 'tempo(6i)' => '14')
  end

  it { expect(record.tempo).to be_a(::DateTime) }
  it { expect(record.tempo.year).to eq(9) }
  it { expect(record.tempo.month).to eq(10) }
  it { expect(record.tempo.day).to eq(11) }
  it { expect(record.tempo.hour).to eq(12) }
  it { expect(record.tempo.minute).to eq(13) }
  it { expect(record.tempo.second).to eq(14) }

  describe '#columns_names' do
    it { expect(model.columns_names).to eq(%i[tempo job_id]) }
  end

  describe '#belongs_to' do
    context 'when value is nil' do
      before { record.job = nil }

      it { expect(record).not_to be_valid }
    end

    context 'when values has association type' do
      before { record.job = ::Job.new }

      it { expect(record.job).to be_a(::Job) }
      it { expect(record).to be_valid }
    end

    context 'when value has not association type' do
      it do
        expect { record.job = ::User.new }.to raise_error(::ActiveRecord::AssociationTypeMismatch)
      end
    end
  end
end
