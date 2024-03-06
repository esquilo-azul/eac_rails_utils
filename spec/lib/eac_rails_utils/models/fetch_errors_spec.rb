# frozen_string_literal: true

::RSpec.describe(::EacRailsUtils::Models::FetchErrors) do
  let(:model1) do # rubocop:disable RSpec/IndexedLet
    ::Class.new do
      include ActiveModel::Model
      include EacRailsUtils::Models::FetchErrors
      attr_accessor :name, :age, :account, :country_id, :other

      def self.model_name
        ActiveModel::Name.new(self, nil, 'model1')
      end
    end
  end

  let(:model2) do # rubocop:disable RSpec/IndexedLet
    ::Class.new do
      include ActiveModel::Model
      attr_accessor :name, :myage, :account_id, :country

      validate :my_validate

      def my_validate
        errors.add(:name, 'NAME_ERROR')
        errors.add(:myage, 'MYAGE_ERROR')
        errors.add(:account_id, 'ACCOUNT_ID_ERROR')
        errors.add(:country, 'COUNTRY_ERROR')
      end

      def self.model_name
        ActiveModel::Name.new(self, nil, 'model2')
      end
    end
  end

  let(:m1) { model1.new } # rubocop:disable RSpec/IndexedLet
  let(:m2) { model2.new } # rubocop:disable RSpec/IndexedLet

  before do
    m1.valid?
    m2.valid?
  end

  it { expect(m1.errors).to be_empty }
  it { expect(m2).not_to be_valid }
  it { expect(m2.errors[:name]).not_to be_empty }
  it { expect(m2.errors[:myage]).not_to be_empty }

  describe '#fetch_column_errors' do
    before do
      m1.fetch_column_errors(m2, :myage, :age)
    end

    it { expect(m1.errors[:age]).to eq(m2.errors[:myage]) }
  end

  describe '#fetch_record_errors' do
    context 'with no options' do
      before do
        m1.fetch_record_errors(m2)
      end

      { name: :name, account_id: :account, country: :country_id }.each do |c2, c1|
        it { expect(m1.errors[c1]).to eq(m2.errors[c2]), "c2: #{c2}, c1: #{c1}" }
      end

      it { expect(m1.errors[:age]).to be_empty }
    end

    context 'with default column option' do
      before do
        m1.fetch_record_errors(m2, default_column: :other)
      end

      it { expect(m1.errors[:name]).to eq(m2.errors[:name]) }
      it { expect(m1.errors[:age]).to be_empty }
      it { expect(m1.errors[:other]).to eq(['Myage: MYAGE_ERROR']) }
    end

    context 'with skip option' do
      before do
        m1.fetch_record_errors(m2, skip: [:name])
      end

      it { expect(m1.errors[:age]).to be_empty }
      it { expect(m1.errors[:name]).to be_empty }
    end
  end

  describe '#fetch_record_errors_by_mapping' do
    before do
      m1.fetch_record_errors_by_mapping(m2, name: :name, myage: :age)
    end

    it { expect(m1.errors[:name]).to eq(m2.errors[:name]) }
    it { expect(m1.errors[:age]).to eq(m2.errors[:myage]) }
  end
end
