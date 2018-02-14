# frozen_string_literal: true
require 'test_helper'

module Eac
  class SourceTargetFixturesTest < ActionView::TestCase
    def test_source_target_files
      r = ::Eac::SourceTargetFixtures.new(fixtures_dir).source_target_files
      assert_equal 3, r.count

      a = r.find { |x| x.source && File.basename(x.source) == 'a.source.html' }
      assert a
      assert_equal File.join(fixtures_dir, 'a.source.html'), a.source
      assert_equal File.join(fixtures_dir, 'a.target.yaml'), a.target

      b = r.find { |x| x.source && File.basename(x.source) == 'b.source.html' }
      assert b
      assert_equal File.join(fixtures_dir, 'b.source.html'), b.source
      assert_nil b.target

      c = r.find { |x| x.target && File.basename(x.target) == 'c.target.yaml' }
      assert c
      assert_nil c.source
      assert_equal File.join(fixtures_dir, 'c.target.yaml'), c.target
    end

    private

    def fixtures_dir
      File.expand_path('../source_target_fixtures_test_files', __FILE__)
    end
  end
end
