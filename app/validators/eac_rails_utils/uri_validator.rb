# frozen_string_literal: true

require 'addressable'

module EacRailsUtils
  class UriValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      r = ::Addressable::URI.parse(value)
      raise ::Addressable::URI::InvalidURIError, 'No scheme' if r.scheme.blank?
    rescue ::Addressable::URI::InvalidURIError => e
      record.errors.add(attribute, options[:message] || e.message)
    end
  end
end
