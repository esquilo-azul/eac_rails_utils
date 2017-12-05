# frozen_string_literal: true
module Eac
  class TablelessModel
    include ActiveModel::Model
    include Virtus.model
    include ActiveModel::Associations

    # need hash like accessor, used internal Rails
    def [](attr)
      send(attr)
    end

    # need hash like accessor, used internal Rails
    def []=(attr, value)
      send("#{attr}=", value)
    end

    def save!
      save || raise("#{self.class}.save failed: #{errors.messages}")
    end
  end
end
