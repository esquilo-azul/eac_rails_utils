# frozen_string_literal: true

RSpec.describe(::EacRailsUtils::Menus::Group) do
  let(:root) { described_class.new(:root, nil) }
  let(:sub1) { root.group(:sub1) }
  let(:sub1_1) { sub1.group(:sub1_1) } # rubocop:disable Naming/VariableNumber
  let(:action1) { sub1.action(:action1) } # rubocop:disable RSpec/IndexedLet
  let(:action2) { sub1_1.action(:engine2, :action1) } # rubocop:disable RSpec/IndexedLet

  describe '#label_translate_key' do
    {
      root: 'eac_rails_utils.menus.root.__self',
      sub1: 'eac_rails_utils.menus.root.sub1.__self',
      sub1_1: 'eac_rails_utils.menus.root.sub1.sub1_1.__self', # rubocop:disable Naming/VariableNumber
      action1: 'eac_rails_utils.menus.root.sub1.main_app_action1',
      action2: 'eac_rails_utils.menus.root.sub1.sub1_1.engine2_action1'
    }.each do |node_key, expected|
      context "when node is \"#{node_key}\"" do
        let(:node) { send(node_key) }

        it do
          expect(node.label_translate_key).to eq(expected)
        end
      end
    end
  end
end
