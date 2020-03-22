# frozen_string_literal: true

module Eac
  # https://stackoverflow.com/questions/10070786/rails-3-validation-presence-false
  class NoPresenceValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, _value)
      return if record.send(attribute).blank?

      record.errors[attribute] << (options[:message] || 'must be blank')
    end
  end
end
