# frozen_string_literal: true

require 'yaml'

module Eac
  module Parsers
    module FilesTest
      def test_data
        if ENV['EAC_PARSERS_FILES_TEST_WRITE'].present?
          write_results
        else
          test_results
        end
      end

      protected

      def source_data(source_file)
        parser_class.new(source_file).data
      end

      def test_results
        sts = source_target_fixtures.source_target_files
        assert_not_equal 0, sts.count, 'Source/target files count cannot be zero'
        sts.each do |st|
          assert_source_target_complete(st)
          sd = source_data(st.source)
          td = YAML.load_file(st.target)
          assert_equal sort_results(td), sort_results(sd)
        end
      end

      def write_results
        source_target_fixtures.source_files.each do |source_file|
          sd = sort_results(source_data(source_file))
          basename = ::Eac::SourceTargetFixtures.source_target_basename(source_file)
          target_file = File.expand_path("../#{basename}.target.yaml", source_file)
          File.write(target_file, sd.to_yaml)
        end
      end

      def sort_results(r)
        r
      end

      private

      def assert_source_target_complete(st)
        assert st.source, "Source not found (Target: #{st.target})"
        assert st.target, "Target not found (Source: #{st.source})"
      end

      def source_target_fixtures
        @source_target_fixtures ||= ::Eac::SourceTargetFixtures.new(
          File.expand_path("../#{self.class.name.demodulize.underscore}_files", test_file)
        )
      end

      def parser_class
        self.class.name.gsub(/Test\z/, '').constantize
      end
    end
  end
end
