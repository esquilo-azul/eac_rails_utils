# frozen_string_literal: true

class ImmutableStub < ActiveRecord::Base
  validates :immutable_attr, 'eac_rails_utils/immutable' => true
end
