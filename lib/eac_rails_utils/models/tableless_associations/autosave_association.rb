# frozen_string_literal: true

module EacRailsUtils
  module Models
    module TablelessAssociations
      module AutosaveAssociation
        extend ActiveSupport::Concern

        include ActiveRecord::AutosaveAssociation

        included do
          extend ActiveModel::Callbacks

          define_model_callbacks :save, :create, :update
        end
      end
    end
  end
end
