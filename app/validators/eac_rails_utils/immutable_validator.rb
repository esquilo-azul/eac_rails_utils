# frozen_string_literal: true

module EacRailsUtils
  class ImmutableValidator < ActiveModel::EachValidator
    DEFAULT_MESSAGE = 'cannot be changed'

    def validate_each(record, attribute, _value)
      return if record.new_record?
      return unless record.send("#{attribute}_changed?")

      record.errors[attribute] << (options[:message] || DEFAULT_MESSAGE)
    end
  end
end
