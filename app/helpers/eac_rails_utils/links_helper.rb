# frozen_string_literal: true

module EacRailsUtils
  module LinksHelper
    def short_delete_link(object)
      short_object_link object, action: '', class: 'delete_link', method: :delete, target: '_blank',
                                title_translation: 'eac_rails_utils.links.delete_object',
                                confirm_translation: 'eac_rails_utils.links.delete_confirm'
    end

    def short_edit_link(object)
      short_object_link object, action: 'edit', class: 'edit_link', target: '_blank',
                                title_translation: 'eac_rails_utils.links.edit_object'
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

    private

    def short_detail_show_link(object, detail)
      short_object_link object,
                        action: detail ? 'detail' : nil,
                        class: 'show_link', target: '_blank',
                        title_translation: 'eac_rails_utils.links.show_object'
    end

    def short_object_link(object, options = {})
      object_link(object, options.merge(name: ''))
    end

    require_sub __FILE__, require_mode: :kernel
  end
end
