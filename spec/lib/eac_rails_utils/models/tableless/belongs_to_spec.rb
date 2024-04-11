# frozen_string_literal: true

RSpec.describe(EacRailsUtils::Models::Tableless) do # rubocop:disable RSpec/FilePath, RSpec/SpecFilePathFormat
  let(:model) do
    Class.new(described_class) do
      def self.name
        'StubbedTablelessModel'
      end

      attribute :job_id, Integer
      belongs_to :job, class_name: 'Job'
      validates :job, presence: true # rubocop:disable Rails/RedundantPresenceValidationOnBelongsTo
    end
  end
  let(:record) { model.new }

  describe '#belongs_to' do
    context 'when value is nil' do
      before { record.job = nil }

      it { expect(record).not_to be_valid }
    end

    context 'when value is set by foreign key' do
      let(:job) { Job.create!(name: 'A Job') }

      before do
        record.job_id = job.id
      end

      it { expect(job.id).to be_present }
      it { expect(record.job).to be_a(Job) }
      it { expect(record).to be_valid }
    end

    context 'when values has association type' do
      before { record.job = Job.new }

      it { expect(record.job).to be_a(Job) }
      it { expect(record).to be_valid }
    end

    context 'when value has not association type' do
      it do
        expect { record.job = User.new }.to raise_error(ActiveRecord::AssociationTypeMismatch)
      end
    end
  end
end
