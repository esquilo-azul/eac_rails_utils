# frozen_string_literal: true

require 'test_helper'

module Eac
  class CpfValidatorTest < ActiveSupport::TestCase
    class M1
      include ActiveModel::Model

      attr_accessor :cpf

      validates :cpf, 'eac/cpf' => true, allow_nil: true
    end

    def setup
      @record = M1.new
    end

    def test_valid_cpfs
      ['85630275305', '66244374487', nil].each do |v|
        @record.cpf = v
        @record.valid?
        assert_equal [], @record.errors[:cpf], "CPF: \"#{v}\""
      end
    end

    def test_invalid_cpfs
      ['', ' ', 'abc', '856.302.753-05', '662.443.744-87', '85630275304'].each do |v|
        @record.cpf = v
        @record.valid?
        assert_not_equal [], @record.errors[:cpf], "CPF: \"#{v}\""
      end
    end
  end
end
