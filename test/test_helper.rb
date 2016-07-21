ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../test/dummy/config/environment.rb', __FILE__)
require 'rails/test_help'

module ActiveSupport
  class TestCase
    def reset_test_database
      ActiveRecord::Tasks::DatabaseTasks.load_schema_current(:ruby, ENV['SCHEMA'])
    end
  end
end
