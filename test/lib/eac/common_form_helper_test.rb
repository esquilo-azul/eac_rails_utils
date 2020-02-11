# frozen_string_literal: true

require 'test_helper'

module Eac
  class CommonFormHelperTest < ActionView::TestCase
    include Eac::CommonFormHelper

    setup do
      reset_test_database
    end

    test 'test common form' do
      common_form(User.new) do |f|
        f.text_field :name
        f.email_field :email
        f.password_field :password
        f.searchable_association_field :job, url: search_jobs_path
      end
    end

    test 'fields for' do
      common_form(Job.new) do |f|
        f.text_field :name
        f.fields_for :users do |nf|
          nf.text_field :name
          nf.email_field :email
          nf.password_field :password
        end
      end
    end
  end
end
