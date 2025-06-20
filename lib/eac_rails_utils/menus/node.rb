# frozen_string_literal: true

module EacRailsUtils
  module Menus
    class Node
      LABEL_TRANSLATE_KEY_PREFIX = 'eac_rails_utils.menus'
      TRANSLATE_KEY_SEPARATOR = '.'

      acts_as_abstract :key
      common_constructor :parent_group
      compare_by :label
      attr_reader :custom_label

      # @return [String]
      def auto_label
        ::I18n.t(label_translate_key)
      end

      # @param custom_label [String, nil]
      # @return [String, self]
      def label(custom_label = nil)
        if custom_label.present?
          self.custom_label = custom_label
          self
        else
          (self.custom_label || auto_label).call_if_proc
        end
      end

      # @return [String]
      def label_translate_key
        parent_label_translate_key
      end

      # @return [String]
      def parent_label_translate_key
        [
          parent_group.if_present(LABEL_TRANSLATE_KEY_PREFIX, &:parent_label_translate_key),
          key
        ].join(TRANSLATE_KEY_SEPARATOR)
      end

      private

      attr_writer :custom_label
    end
  end
end
