# frozen_string_literal: true

require 'test_helper'

module EacRailsUtils
  module Models
    class TablelessTest < ActiveSupport::TestCase
      class Stub < ::EacRailsUtils::Models::Tableless
        attribute :tempo, DateTime
      end

      test 'date time array values' do
        stub = Stub.new('tempo(1i)' => '9', 'tempo(2i)' => '10', 'tempo(3i)' => '11',
                        'tempo(4i)' => '12', 'tempo(5i)' => '13', 'tempo(6i)' => '14')
        assert stub.tempo.is_a?(DateTime), "Class: |#{stub.tempo.class}|, Value: |#{stub.tempo}|"
        assert_equal 9, stub.tempo.year, 'Year'
        assert_equal 10, stub.tempo.month, 'Month'
        assert_equal 11, stub.tempo.day, 'Day'
        assert_equal 12, stub.tempo.hour, 'Hour'
        assert_equal 13, stub.tempo.minute, 'Minute'
        assert_equal 14, stub.tempo.second, 'Second'
      end
    end
  end
end
