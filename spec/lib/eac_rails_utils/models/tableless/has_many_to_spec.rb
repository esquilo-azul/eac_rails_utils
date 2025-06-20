# frozen_string_literal: true

RSpec.describe(EacRailsUtils::Models::Tableless) do # rubocop:disable RSpec/RSpec/SpecFilePathFormat
  let(:tableless_job_model) do
    Class.new(described_class) do
      def self.name
        'TablelessJob'
      end

      attribute :id, Integer
      has_many :users, class_name: 'User', foreign_key: :job_id

      def self.primary_key
        'id'
      end
    end
  end
  let(:real_job) { Job.create! }
  let(:user1) { User.create!(job: real_job, email: 'user1@example.com', password: 'abc123') } # rubocop:disable RSpec/IndexedLet
  let(:user2) { User.create!(job: real_job, email: 'user2@example.com', password: 'abc123') } # rubocop:disable RSpec/IndexedLet
  let(:tableless_job_record) { tableless_job_model.new }

  describe '#has_many' do
    before do
      user1
      user2
      tableless_job_record.id = real_job.id
    end

    it { expect(real_job.users.count).to eq(2) }
    it { expect(tableless_job_record.id).to be_present }
    it { expect(tableless_job_record.users.count).to eq(2) }
  end
end
