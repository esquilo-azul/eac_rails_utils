# frozen_string_literal: true

def patch_json?
  require 'json'

  ::Gem::Version.new(RUBY_VERSION) >= ::Gem::Version.new('2.7') &&
    ::Gem::Version.new(JSON::VERSION) < ::Gem::Version.new('2')
rescue ::LoadError
  false
end

if patch_json?
  module JSON
    module_function

    def parse(source, opts = {})
      Parser.new(source, **opts).parse
    end
  end
end
