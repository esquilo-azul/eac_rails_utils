# frozen_string_literal: true

RSpec.describe ::EacRailsUtils::Models::Validations do
  let(:stub_model) do
    ::Class.new do
      def self.model_name
        ActiveModel::Name.new(self, nil, 'StubModel')
      end
      include ActiveModel::Model
      attr_accessor :age, :name

      validates :age, allow_nil: true, numericality: {
        only_integer: true,
        greater_than_or_equal_to: 0, less_than_or_equal_to: 150
      }
      validates :name, presence: true
    end
  end

  before do
    stub_const('StubModel', stub_model)
  end

  describe '#column/attribute_errors/valid?' do
    { StubModel: [[:name, nil, false], [:name, 'Fulano', true], [:age, nil, true],
                  [:age, 200, false], [:age, 40, true]] }.each do |model_const, test_datas|
      test_datas.each do |test_data|
        context "with model #{model_const} and test_data=#{test_data}" do
          attribute, value, valid = test_data
          errop = valid ? :to : :not_to

          let(:model) { ::Object.const_get(model_const) }

          before { model.include(described_class) }

          it {
            expect(described_class.column_errors(model, attribute, value)).send(errop, be_empty)
          }

          it { expect(described_class.column_valid?(model, attribute, value)).to eq(valid) }
          it { expect(model.column_errors(attribute, value)).send(errop, be_empty) }
          it { expect(model.column_valid?(attribute, value)).to eq(valid) }

          it {
            expect(model.new(attribute => value).attribute_errors(attribute)).send(errop, be_empty)
          }

          it { expect(model.new(attribute => value).attribute_valid?(attribute)).to eq(valid) }
        end
      end
    end
  end

  describe '#column/attribute_required?' do
    { StubModel: [[:age, false], [:name, true]],
      User: [[:job, true], [:password, true], [:email, true]] }.each do |model_const, test_datas|
      test_datas.each do |test_data|
        context "with model #{model_const} and test_data=#{test_data}" do
          let(:model) { ::Object.const_get(model_const) }
          let(:attribute) { test_data[0] }
          let(:expected) { test_data[1] }

          before { model.include(described_class) }

          it { expect(described_class.column_required?(model, attribute)).to eq(expected) }
          it { expect(model.column_required?(attribute)).to eq(expected) }
          it { expect(model.new.attribute_required?(attribute)).to eq(expected) }
        end
      end
    end
  end
end
