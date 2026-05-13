# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

gem 'rails', '>= 6.1.7.10', '< 7'

local_gemfile = File.join(File.dirname(__FILE__), 'Gemfile.local')
eval_gemfile local_gemfile if File.exist?(local_gemfile)
