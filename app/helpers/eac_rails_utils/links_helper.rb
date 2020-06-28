# frozen_string_literal: true

module EacRailsUtils
  module LinksHelper
    def short_delete_link(object)
      short_object_link object, '', class: 'delete_link', method: :delete, target: '_blank',
                                    title: ::I18n.t('eac_rails_utils.links.delete_object',
                                                    label: object.to_s),
                                    data: {
                                      confirm: ::I18n.t('eac_rails_utils.links.delete_confirm',
                                                        label: object.to_s)
                                    }
    end

    def short_edit_link(object)
      short_object_link object, 'edit', class: 'edit_link', target: '_blank',
                                        title: ::I18n.t('eac_rails_utils.links.edit_object',
                                                        label: object.to_s)
    end

    def short_goto_link(url)
      value_or_sign(url, '') do |value|
        link_to '', value, class: 'goto_link', target: '_blank',
                           title: ::I18n.t('eac_rails_utils.links.goto_url', url: value.to_s),
                           rel: 'noopener'
      end
    end

    def short_show_link(object)
      short_detail_show_link(object, false)
    end

    def short_detail_link(object)
      short_detail_show_link(object, true)
    end

    def object_path(object, action = nil)
      current_class = object_class(object)
      tried_paths = []
      while current_class
        path = object_path_by_class(current_class, action)
        return send(path, object) if respond_to?(path)

        tried_paths << path
        current_class = current_class.superclass
      end
      raise "Path not found for {object: #{object.class}, action: \"#{action}\"}" \
        "(Tried: #{tried_paths})"
    end

    private

    def short_detail_show_link(object, detail)
      short_object_link object,
                        detail ? 'detail' : nil,
                        class: 'show_link', target: '_blank',
                        title: ::I18n.t('eac_rails_utils.links.show_object', label: object.to_s)
    end

    def short_object_link(object, action = nil, options = {})
      value_or_sign(object, '') do |value|
        link_to '', object_path(value, action), options
      end
    end

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
