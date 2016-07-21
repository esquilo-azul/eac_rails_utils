class Job < ActiveRecord::Base
  has_many :users
  accepts_nested_attributes_for :users, reject_if: :all_blank, allow_destroy: true
end
