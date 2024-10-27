# frozen_string_literal: true

module EacRailsUtils
  module LinksHelper
    class ObjectPath
      acts_as_instance_method
      common_constructor :view, :object, :action, default: [nil]

      def result
        current_class = object_class(object)
        tried_paths = []
        while current_class
          path = object_path_by_class(current_class, action)
          return view.send(path, object) if view.respond_to?(path)

          tried_paths << path
          current_class = current_class.superclass
        end
        raise "Path not found for {object: #{object.class}, action: \"#{action}\"}" \
              "(Tried: #{tried_paths})"
      end

      protected

      def object_path_by_class(klass, action)
        path = "#{klass.name.underscore.tr('/', '_')}_url"
        path = "#{action}_#{path}" if action.present?
        path
      end

      def object_class(object)
        return object.entity_class if object.respond_to?(:entity_class)
        return object.__getobj__.class if object.respond_to?(:__getobj__)

        object.class
      end
    end
  end
end
