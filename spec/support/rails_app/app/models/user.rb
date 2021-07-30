# frozen_string_literal: true

class User < ActiveRecord::Base
  belongs_to :job

  validates :job, presence: true
  validates :password, presence: true
  validates :email, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
end
