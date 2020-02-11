# frozen_string_literal: true

require 'test_helper'

module EacRailsUtils
  module Patches
    class ModelAttributeRequiredTest < ActiveSupport::TestCase
      setup do
        reset_test_database
      end

      test 'column with presence validator should be required' do
        assert User.column_required?(:password)
      end

      test 'column with format validator should be required' do
        assert User.column_required?(:email)
      end

      test 'column without validators should be optional' do
        assert_not User.column_required?(:name)
      end

      test 'association with presence validator should be required' do
        assert User.column_required?(:job)
      end

      test 'required column in active model' do
        assert ActiveModelStub.column_required?(:name), 'name is required'
        assert_not ActiveModelStub.column_required?(:age), 'age is optional'
      end

      class ActiveModelStub
        include ActiveModel::Model

        attr_accessor :name, :age
        validates :name, presence: true
      end
    end
  end
end
