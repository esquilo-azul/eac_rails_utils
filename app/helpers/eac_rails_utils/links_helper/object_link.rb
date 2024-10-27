# frozen_string_literal: true

module EacRailsUtils
  module LinksHelper
    # @param object [Object]
    # @param options [Hash] All the values are passed to the link_to method with except of:
    #   * :action : argument +action+ for the method +object_path+.
    #   * :name : argument +name+ for the method +link_to+.
    # @return [ActiveSupport::SafeBuffer] The link or the blank_sign.
    class ObjectLink
      acts_as_instance_method
      common_constructor :view, :object, :options, default: [{}]

      NON_LINK_TO_OPTIONS = %i[action name].freeze

      # @return [ActiveSupport::SafeBuffer]
      def result
        view.value_or_sign(object, '') do |value|
          view.link_to name, view.object_path(value, action), link_to_options
        end
      end

      # @return [String, nil]
      def action
        options[:action]
      end

      # @return [String, nil]
      def name
        options[:name] || object.to_s
      end

      protected

      # @return [Hash]
      def link_to_options
        options.except(*NON_LINK_TO_OPTIONS)
      end
    end
  end
end
