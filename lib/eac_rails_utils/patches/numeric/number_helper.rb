# frozen_string_literal: true

require 'action_view/helpers/number_helper'

class Numeric
  DEFAULT_PRECISION = 2

  class << self
    # @return [Object] A object that extends [ActionView::Helpers::NumberHelper]
    def number_helper
      @number_helper ||= begin
        r = ::Object.new
        r.extend(::ActionView::Helpers::NumberHelper)
        r
      end
    end
  end

  def default_precision_options(options = {})
    r = options.dup
    r[:precision] = DEFAULT_PRECISION
    r
  end

  # @return [Object] A object that extends [ActionView::Helpers::NumberHelper]
  delegate :number_helper, to: :class

  # @return [String]
  def to_currency(options = {})
    number_helper.number_to_currency(self, default_precision_options(options))
  end

  # @return [String]
  def to_human(options = {})
    number_helper.number_to_human(self, default_precision_options(options))
  end

  # @return [String]
  def to_human_size(options = {})
    number_helper.number_to_human_size(self, default_precision_options(options))
  end

  # @return [String]
  def to_percentage(options = {})
    number_helper.number_to_percentage(self, default_precision_options(options))
  end

  # @return [String]
  def to_phone(options = {})
    number_helper.number_to_phone(self, options)
  end

  # @return [String]
  def with_delimiter(options = {})
    number_helper.number_with_delimiter(self, options)
  end

  # @return [String]
  def with_precision(options = {})
    number_helper.number_with_precision(self, default_precision_options(options))
  end
end
