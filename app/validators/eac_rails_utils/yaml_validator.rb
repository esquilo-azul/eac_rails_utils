# frozen_string_literal: true

module EacRailsUtils
  class YamlValidator < ActiveModel::EachValidator
    DEFAULT_INVALID_YAML_MESSAGE = 'is not a valid YAML'
    DEFAULT_TO_S_UNAVAILABLE_MESSAGE = 'should respond to .to_s'
    DEFAULT_NOT_A_STRING_MESSAGE = '.to_s do not returned a String'

    def validate_each(record, attribute, value)
      return if value.blank?

      string_value = stringfy_value(value)
      return if string_value.nil?

      return if ::EacRubyUtils::Yaml.yaml?(string_value)

      record.errors.add(attribute, options[:message] || DEFAULT_INVALID_YAML_MESSAGE)
    end

    protected

    # @param value [Object]
    # @return [String, nil]
    def stringfy_value(value)
      unless value.respond_to?(:to_s)
        record.errors.add(attribute, options[:message] || DEFAULT_TO_S_UNAVAILABLE_MESSAGE)
        return nil
      end

      r = value.to_s
      return r if value.is_a?(::String)

      record.errors.add(attribute, options[:message] || DEFAULT_NOT_A_STRING_MESSAGE)
      nil
    end
  end
end
