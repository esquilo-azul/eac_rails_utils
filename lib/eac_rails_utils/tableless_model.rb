# frozen_string_literal: true

module EacRailsUtils
  class TablelessModel
    include ActiveModel::Model
    include Virtus.model
    include ActiveModel::Associations

    def initialize(values = {})
      super(build_attributes(values))
    end

    def attributes=(values)
      super(build_attributes(values))
    end

    # need hash like accessor, used internal Rails
    def [](attr)
      send(attr)
    end

    # need hash like accessor, used internal Rails
    def []=(attr, value)
      send("#{attr}=", value)
    end

    def save!
      save || raise("#{self.class}.save failed: #{errors.messages}")
    end

    private

    def build_attributes(values)
      AttributesBuilder.new(self.class, values).to_attributes
    end

    class AttributesBuilder
      DATE_TIME_FIELDS = %i[year month day hour min sec].freeze

      def initialize(model_class, values)
        @model_class = model_class
        @values = {}
        values.each { |k, v| add(k, v) }
      end

      def to_attributes
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
