# frozen_string_literal: true

require 'eac_rails_utils/models/attribute_required'

class User < ActiveRecord::Base
  include ::EacRailsUtils::Models::AttributeRequired

  belongs_to :job

  validates :job, presence: true
  validates :password, presence: true
  validates :email, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
end
