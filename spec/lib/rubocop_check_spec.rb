# frozen_string_literal: true

require 'eac_ruby_gem_support/spec/examples/rubocop_check'

RSpec.describe ::RuboCop do
  include_examples 'rubocop_check', ::File.expand_path('../..', __dir__)
end
