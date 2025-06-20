# frozen_string_literal: true

class Job < ActiveRecord::Base
  has_many :users # rubocop:disable Rails/HasManyOrHasOneDependent
  accepts_nested_attributes_for :users, reject_if: :all_blank, allow_destroy: true
end
