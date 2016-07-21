require 'test_helper'

module Eac
  class ModelTest < ActiveSupport::TestCase
    class M1
      include ActiveModel::Model
      include Eac::Model
      attr_accessor :name, :age, :account, :country_id, :other
    end

    class M2
      include ActiveModel::Model
      attr_accessor :name, :myage, :account_id, :country

      validate :my_validate

      def my_validate
        errors.add(:name, 'NAME_ERROR')
        errors.add(:myage, 'MYAGE_ERROR')
        errors.add(:account_id, 'ACCOUNT_ID_ERROR')
        errors.add(:country, 'COUNTRY_ERROR')
      end
    end

    def setup
      reset_m1
      reset_m2
    end

    def test_fetch_column_errors
      @m1.fetch_column_errors(@m2, :myage, :age)
      assert_equal @m2.errors[:myage], @m1.errors[:age]
    end

    def test_fetch_record_errors
      @m1.fetch_record_errors(@m2)
      { name: :name, account_id: :account, country: :country_id }.each do |c2, c1|
        assert_equal @m2.errors[c2], @m1.errors[c1], "c2: #{c2}, c1: #{c1}"
      end
      assert @m1.errors[:age].empty?
    end

    def test_fetch_record_errors_with_default_column
      @m1.fetch_record_errors(@m2, default_column: :other)
      assert_equal @m2.errors[:name], @m1.errors[:name]
      assert @m1.errors[:age].empty?
      assert_equal ['Myage: MYAGE_ERROR'], @m1.errors[:other]
    end

    def test_fetch_record_errors_with_skip_option
      @m1.fetch_record_errors(@m2, skip: [:name])
      assert @m1.errors[:name].empty?
      assert @m1.errors[:age].empty?
    end

    def test_fetch_record_errors_by_mapping
      @m1.fetch_record_errors_by_mapping(@m2, name: :name, myage: :age)
      assert_equal @m2.errors[:name], @m1.errors[:name]
      assert_equal @m2.errors[:myage], @m1.errors[:age]
    end

    private

    def reset_m1
      @m1 = M1.new
      assert @m1.errors.empty?
    end

    def reset_m2
      @m2 = M2.new
      assert_not @m2.valid?
      assert_not @m2.errors[:name].empty?
      assert_not @m2.errors[:myage].empty?
    end
  end
end
