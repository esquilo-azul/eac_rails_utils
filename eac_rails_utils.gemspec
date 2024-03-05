# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'eac_rails_utils/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'eac_rails_utils'
  s.version     = EacRailsUtils::VERSION
  s.authors     = ['E.A.C.']
  s.summary     = 'Código reutilizável para as aplicações Rails da E.A.C..'

  s.files = Dir['{app,config,db,lib}/**/*', 'Rakefile']

  s.add_dependency 'bootstrap-sass', '~> 3.4', '>= 3.4.1'
  s.add_dependency 'eac_ruby_utils', '~> 0.121'
  s.add_dependency 'htmlbeautifier', '~> 1.4', '>= 1.4.3'
  s.add_dependency 'rails', '>= 4.2.11'
  s.add_dependency 'virtus', '~> 2.0'

  # Formulários aninhados
  # https://github.com/ncri/nested_form_fields
  s.add_dependency 'nested_form_fields', '~> 0.8', '>= 0.8.4'

  s.add_development_dependency 'eac_rails_gem_support', '~> 0.9', '>= 0.9.2'
end
