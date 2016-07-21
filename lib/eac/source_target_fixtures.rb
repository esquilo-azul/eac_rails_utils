# encoding: UTF-8
# frozen_string_literal: true

require 'yaml'

module Eac
  class SourceTargetFixtures
    attr_reader :fixtures_directory

    def initialize(fixtures_directory)
      @fixtures_directory = fixtures_directory
    end

    def source_target_files(&block)
      sources_targets_basenames.each do |test_basename|
        block.call(source_file(test_basename), target_file(test_basename))
      end
    end

    private

    def target_file(basename)
      fixture_file(basename, 'target')
    end

    def source_file(basename)
      fixture_file(basename, 'source')
    end

    def fixture_file(basename, suffix)
      prefix = "#{basename}.#{suffix}"
      Dir.foreach(fixtures_directory) do |item|
        next if item == '.' || item == '..'
        return File.expand_path(item, fixtures_directory) if item.starts_with?(prefix)
      end
      fail "\"#{prefix}\" not found (Basename: #{basename}, Suffix: #{suffix})"
    end

    def sources_targets_basenames
      basenames = []
      Dir.foreach(fixtures_directory) do |item|
        next if item == '.' || item == '..'
        if /^(.+)\.(?:source|target)(?:\..+)?$/ =~ File.basename(item)
          basenames << Regexp.last_match(1)
        end
      end
      fail "\"#{fixtures_directory}\" não possui nenhum arquivo para teste." if basenames.empty?
      basenames
    end
  end
end
