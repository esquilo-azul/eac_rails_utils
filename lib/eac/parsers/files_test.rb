# frozen_string_literal: true
require 'yaml'

module Eac
  module Parsers
    module FilesTest
      def test_data
        source_target_fixtures.source_target_files do |source_file, target_file|
          sd = parser_class.new(source_file).data
          td = YAML.load_file(target_file)
          assert_equal sort_results(td), sort_results(sd)
        end
      end

      protected

      def sort_results(r)
        r
      end

      private

      def source_target_fixtures
        ::Eac::SourceTargetFixtures.new(
          File.expand_path("../#{self.class.name.demodulize.underscore}_files", test_file)
        )
      end

      def parser_class
        self.class.name.gsub(/Test\z/, '').constantize
      end
    end
  end
end
