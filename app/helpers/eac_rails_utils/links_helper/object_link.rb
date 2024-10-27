# frozen_string_literal: true

module EacRailsUtils
  module LinksHelper
    # @param object [Object]
    # @param options [Hash] All the values are passed to the link_to method with except of:
    #   * :action : argument +action+ for the method +object_path+.
    #   * :blank_value : text used when +object+ is blank.
    #   * :confirm_translation: translation key for attribute +data.confirm+.
    #   * :name : argument +name+ for the method +link_to+.
    # @return [ActiveSupport::SafeBuffer] The link or the blank_sign.
    class ObjectLink
      acts_as_instance_method
      common_constructor :view, :object, :options, default: [{}]

      NON_LINK_TO_OPTIONS = %i[action blank_value confirm_translation name].freeze

      # @return [ActiveSupport::SafeBuffer]
      def result
        view.value_or_sign(object, blank_value) do |value|
          view.link_to name, view.object_path(value, action), link_to_options
        end
      end

      # @return [String, nil]
      def action
        options[:action]
      end

      # @return [String, nil]
      def blank_value
        options[:blank_value]
      end

      # @return [String, nil]
      def confirm
        options[:confirm_translation].if_present do |v|
          ::I18n.t(v, label: object.to_s)
        end
      end

      # @return [String, nil]
      def name
        options[:name] || object.to_s
      end

      protected

      def apply_confirm(options)
        confirm.if_present do |v|
          options[:data] ||= {}
          options[:data][:confirm] = v
        end
      end

      # @return [Hash]
      def link_to_options
        %w[confirm].each_with_object(options.except(*NON_LINK_TO_OPTIONS)) do |e, a|
          send("apply_#{e}", a)
        end
      end
    end
  end
end
