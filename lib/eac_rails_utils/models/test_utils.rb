# frozen_string_literal: true

module EacRailsUtils
  module Models
    module TestUtils
      # Add more helper methods to be used by all tests here...
      def valid_invalid_column_values_test(record, column, valid_values, invalid_values)
        valid_values.each do |v|
          record.send("#{column}=", v)
          assert record.valid?,
                 "#{record.errors.messages}, #{column} = #{v.inspect} should be valid"
        end
        invalid_values.each do |v|
          record.send("#{column}=", v)
          assert_not record.valid?, "#{column} = #{v.inspect} should be invalid"
        end
      end

      # Verifica falhas em campos específicos de um record
      def assert_record_errors(record, fields_without_error, fields_with_error)
        fields_without_error.each do |c|
          assert record.errors[c].empty?,
                 "Column: #{c} should not have errors (#{record.errors[c]})"
        end
        fields_with_error.each do |c|
          assert_not record.errors[c].empty?, "Column: #{c} should have errors"
        end
      end

      # Verifica, campo por campo, se invalida o registro.
      def assert_column_changes(ppp, expected_valid_result, changes)
        changes.each do |k, v|
          ppp.send("#{k}=", v)
          assert_equal expected_valid_result, ppp.valid?,
                       "\"#{k}\" change should be " + (expected_valid_result ? 'valid' : 'invalid')
          assert_not ppp.errors[k].empty? unless expected_valid_result
          ppp.restore_attributes
        end
      end

      # Ex.: attrs = {a: 1, b: 2} resulta em
      # [{a: nil, b: nil}, {a: 1, b: nil}, {a: nil, b: 2}, {a: 1, b: 2}].
      def all_combinations(attrs)
        combs = [{}]
        attrs.each do |attr_name, value|
          combs = all_combinations_new_combination(attr_name, value, combs)
        end
        combs
      end

      def all_combinations_new_combination(attr_name, value, combs)
        new_comb = []
        assert_not value.nil?, "#{attr_name}=#{value}"
        [nil, value].each do |vv|
          combs.each do |c|
            cc = c.dup
            cc[attr_name] = vv
            new_comb << cc
          end
        end
        new_comb
      end
    end
  end
end
