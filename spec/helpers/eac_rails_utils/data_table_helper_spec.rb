# frozen_string_literal: true

RSpec.describe(EacRailsUtils::DataTableHelper, type: :helper) do
  let(:person_class) do
    Class.new do
      attr_reader :name, :age, :job

      def initialize(name, age, job)
        @name = name
        @age = age
        @job = job
      end
    end
  end

  let(:job_class) do
    Class.new do
      attr_reader :name, :id

      def initialize(name)
        @name = name
        @id = SecureRandom.random_number(100_000)
      end
    end
  end

  let(:datasource_list) do
    [person_class.new('Fulano', 15, job_class.new('Padeiro')),
     person_class.new('Sicrano', 25, nil)]
  end

  let(:data_table_result) do
    helper.data_table(datasource_list) do |s|
      s.paging = false
      s.column('Name', 'name')
      s.column('Age', 'age')
      s.column('Name + Age') { |v| "#{v.name} + #{v.age}" }
      s.column('Job', 'job')
      s.column('Job ID', 'job.id')
      s.column('Job ID + 10', 'job.id') { |_v| + 10 }
    end
  end

  it do
    expect(data_table_result).not_to be_blank
  end
end
