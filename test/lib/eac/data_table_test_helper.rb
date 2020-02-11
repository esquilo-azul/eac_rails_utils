# frozen_string_literal: true

require 'test_helper'

module Eac
  class DataTableTestHelper < ActionView::TestCase
    include ::Eac::DataTableHelper

    class Person
      attr_reader :name, :age, :job

      def initialize(name, age, job)
        @name = name
        @age = age
        @job = job
      end
    end

    class Job
      attr_reader :name, :id

      def initialize(name)
        @name = name
        @id = SecureRandom.random_number(100_000)
      end
    end

    def test_data_table
      ds = []
      ds << Person.new('Fulano', 15, Job.new('Padeiro'))
      ds << Person.new('Sicrano', 25, nil)

      data_table(ds) do |s|
        s.paging = false
        s.column('Name', 'name')
        s.column('Age', 'age')
        s.column('Name + Age') { |v| "#{v.name} + #{v.age}" }
        s.column('Job', 'job')
        s.column('Job ID', 'job.id')
        s.column('Job ID + 10', 'job.id') { |_v| + 10 }
      end
    end
  end
end
