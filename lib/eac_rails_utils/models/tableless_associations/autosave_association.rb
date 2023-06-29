module EacRailsUtils::Models::TablelessAssociations
  module AutosaveAssociation
    extend ActiveSupport::Concern

    include ActiveRecord::AutosaveAssociation

    included do
      extend ActiveModel::Callbacks
      define_model_callbacks :save, :create, :update
    end
  end
end
