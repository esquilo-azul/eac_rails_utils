# frozen_string_literal: true
require 'test_helper'

module Eac
  module Parsers
    class BaseStub
      def initialize(source)
        @source = source
      end

      def data
        YAML.load(File.read(@source))
      end
    end

    class Ok < BaseStub
    end

    class OkTest < ActiveSupport::TestCase
      include ::Eac::Parsers::FilesTest

      def test_file
        __FILE__
      end
    end
  end
end
