# ecoding: utf-8
# frozen_string_literal: true

require 'open-uri'
require 'fileutils'

module Eac
  module Parsers
    class Base
      def initialize(url)
        @url = url
      end

      def url
        @url.gsub(%r{/+$}, '')
      end

      def content
        s = content_by_url_type
        log_content(s)
        s
      end

      private

      def content_by_url_type
        if @url.is_a?(Hash)
          content_hash
        elsif /^http/ =~ @url
          content_get
        else
          content_file
        end
      end

      def content_file
        open(@url.gsub(%r{\Afile://}, ''), &:read)
      end

      def content_get
        content_get_fetch(@url)
      end

      def content_get_fetch(uri, limit = 10)
        raise 'too many HTTP redirects' if limit == 0
        uri = Addressable::URI.parse(uri)
        content_get_fetch_result(uri, limit, Net::HTTP.get_response(uri))
      end

      def content_get_fetch_result(uri, limit, response)
        case response
        when Net::HTTPSuccess then
          response.body
        when Net::HTTPRedirection then
          content_get_fetch_redirect(uri, Addressable::URI.parse(response['location']), limit)
        else
          response.value
        end
      end

      def content_get_fetch_redirect(original_uri, redirect_uri, limit)
        if redirect_uri.scheme.blank?
          redirect_uri.scheme = original_uri.scheme
          redirect_uri.authority = original_uri.authority
        end
        Rails.logger.debug("#{original_uri} redirected to #{redirect_uri}")
        content_get_fetch(redirect_uri, limit - 1)
      end

      def content_hash
        return content_post if @url[:method] == :post
        raise "Unknown URL format: #{@url}"
      end

      def content_post
        HTTPClient.new.post_content(@url[:url], @url[:params].merge(follow_redirect: true))
      end

      def log_content(s)
        File.open(log_file, 'wb') { |file| file.write(s) }
      end

      def log_file
        f = Rails.root.join('log', 'parsers', "#{self.class.name.parameterize}.log")
        FileUtils.mkdir_p(File.dirname(f))
        f
      end
    end
  end
end
