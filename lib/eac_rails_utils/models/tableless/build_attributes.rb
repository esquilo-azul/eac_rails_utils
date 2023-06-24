# frozen_string_literal: true

module EacRailsUtils
  module Models
    class Tableless
      class BuildAttributes
        acts_as_instance_method
        DATE_TIME_FIELDS = %i[year month day hour min sec].freeze

        def initialize(model_class, values)
          @model_class = model_class
          @values = {}
          values.each { |k, v| add(k, v) }
        end

        def result
          @values
        end

        private

        def add(key, value)
          array_attr = parse_array_attr_key(key)
          if array_attr
            array_value_set(array_attr, value)
          else
            @values[key] = value
          end
        end

        def parse_array_attr_key(key)
          m = /\A(.+)\(([0-9]+)(.)\)\z/.match(key)
          return unless m

          ::OpenStruct.new(key: m[1], index: m[2].to_i - 1, converter: array_value_converter(m[3]))
        end

        def array_value_set(array_attr, value)
          @values[array_attr.key] ||= {}
          @values[array_attr.key].merge!(
            DATE_TIME_FIELDS[array_attr.index] => value.send(array_attr.converter)
          )
        end

        def array_value_converter(str_type)
          case str_type
          when 'i'
            'to_i'
          else
            raise "Unknown array type: \"#{str_type}\""
          end
        end

        def date_time_attribute?(key)
          attr = @model_class.attributes[key]
          return false unless attr

          raise attr.to_s
        end
      end
    end
  end
end
