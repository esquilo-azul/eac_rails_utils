# frozen_string_literal: true

::RSpec.describe(::EacRailsUtils::YamlValidator) do
  let(:model) do
    ::Class.new do
      include ActiveModel::Model

      def self.name
        'ModelWithYamlAttribute'
      end

      attr_accessor :yaml_attr
      validates :yaml_attr, 'eac_rails_utils/yaml' => true
    end
  end

  let(:record) { model.new }

  {
    false => [
      "---\n*STRING",
      "- V1\n- V2",
      'STRING'
    ],
    true => [
      nil,
      '--- STRING',
      "---\n{}",
      '--- []',
      "---\n- V1\n- V2",
      '',
      '         '
    ]
  }.each do |expected_valid, yaml_attr_values|
    yaml_attr_values.each do |yaml_attr_value|
      context "when yaml field is \"#{yaml_attr_value}\"" do
        before do
          record.yaml_attr = yaml_attr_value
          record.valid?
        end

        if expected_valid
          it { expect(record).to be_valid }
          it { expect(record.errors[:yaml_attr]).to eq([]) }
        else
          it { expect(record).not_to be_valid }
          it { expect(record.errors[:yaml_attr]).not_to eq([]) }
        end
      end
    end
  end
end
