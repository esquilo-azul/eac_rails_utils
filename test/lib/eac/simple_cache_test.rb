# frozen_string_literal: true
require 'test_helper'

module Eac
  class SimpleCacheTest < ActionView::TestCase
    class CacheableObject
      include Eac::SimpleCache

      def my_method_uncached
        @counter ||= 0
        @counter += 1
      end

      def method_with_args_uncached(arg1)
        @counter2 ||= 0
        @counter2 += 1
        "#{arg1}/#{@counter2}"
      end

      private

      def private_method_uncached
        @counter3 ||= 0
        @counter3 += 1
      end
    end

    def setup
      @co = CacheableObject.new
    end

    def test_cached_value
      assert_not_equal @co.my_method_uncached, @co.my_method_uncached
      assert_equal @co.my_method, @co.my_method
    end

    def test_cached_value_with_args
      assert_not_equal @co.method_with_args_uncached('123'), @co.method_with_args_uncached('123')
      assert_not_equal @co.method_with_args_uncached('456'), @co.method_with_args_uncached('456')
      assert_equal @co.method_with_args('123'), @co.method_with_args('123')
      assert_equal @co.method_with_args('456'), @co.method_with_args('456')
      assert_not_equal @co.method_with_args('123'), @co.method_with_args('456')
    end

    def test_private_uncached_method
      assert_equal @co.private_method, @co.private_method
    end

    def test_reset
      @co = CacheableObject.new
      value = @co.my_method
      assert_equal value, @co.my_method
      @co.reset_cache
      assert_not_equal value, @co.my_method
    end
  end
end
