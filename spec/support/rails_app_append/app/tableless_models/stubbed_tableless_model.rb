# frozen_string_literal: true

class StubbedTablelessModel < ::EacRailsUtils::Models::Tableless
  attribute :tempo, DateTime

  attribute :job_id, Integer
  belongs_to :job, class_name: 'Job'
  validates :job, presence: true
end
