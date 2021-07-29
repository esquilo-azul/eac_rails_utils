# frozen_string_literal: true

::RSpec.describe(::EacRailsUtils::CpfValidator) do
  let(:model) do
    ::Class.new do
      include ActiveModel::Model

      attr_accessor :cpf

      validates :cpf, 'eac_rails_utils/cpf' => true, allow_nil: true
    end
  end

  let(:record) { model.new }

  {
    '85630275305' => true, '66244374487' => true, nil => true,
    '' => false, ' ' => false, 'abc' => false, '856.302.753-05' => false, '662.443.744-87' => false,
    '85630275304' => false
  }.each do |cpf, valid|
    context "when cpf is \"#{cpf}\"" do
      before do
        record.cpf = cpf
        record.valid?
      end

      if valid
        it { expect(record).to be_valid }
        it { expect(record.errors[:cpf]).to eq([]) }
      else
        it { expect(record).not_to be_valid }
        it { expect(record.errors[:cpf]).not_to eq([]) }
      end
    end
  end
end
