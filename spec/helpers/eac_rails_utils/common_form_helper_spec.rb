# frozen_string_literal: true

RSpec.describe(::EacRailsUtils::CommonFormHelper, type: :helper) do
  describe '#common_form' do
    it do # rubocop:disable RSpec/ExampleLength
      expect do
        helper.common_form(User.new) do |f|
          f.text_field :name
          f.email_field :email
          f.password_field :password
          f.searchable_association_field :job, url: search_jobs_path
        end
      end.not_to raise_error
    end
  end

  describe '#fields_for' do
    it do # rubocop:disable RSpec/ExampleLength
      expect do
        helper.common_form(Job.new) do |f|
          f.text_field :name
          f.fields_for :users do |nf|
            nf.text_field :name
            nf.email_field :email
            nf.password_field :password
          end
        end
      end.not_to raise_error
    end
  end
end
