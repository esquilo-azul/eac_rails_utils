# frozen_string_literal: true

module EacRailsUtils
  module LinksHelper
    SHORT_LINK_OPTIONS = { name: '', target: '_blank' }.freeze
    SHORT_DELETE_LINK_OPTIONS = SHORT_LINK_OPTIONS.merge(
      action: '', class: 'delete_link', method: :delete,
      title_translation: 'eac_rails_utils.links.delete_object',
      confirm_translation: 'eac_rails_utils.links.delete_confirm'
    ).freeze
    SHORT_EDIT_LINK_OPTIONS = SHORT_LINK_OPTIONS.merge(
      action: 'edit', class: 'edit_link', title_translation: 'eac_rails_utils.links.edit_object'
    ).freeze
    SHORT_DETAIL_SHOW_LINK_OPTIONS = SHORT_LINK_OPTIONS.merge(
      class: 'show_link', title_translation: 'eac_rails_utils.links.show_object'
    ).freeze
    SHORT_DETAIL_LINK_OPTIONS = SHORT_DETAIL_SHOW_LINK_OPTIONS.merge(action: 'detail')
    SHORT_SHOW_LINK_OPTIONS = SHORT_DETAIL_SHOW_LINK_OPTIONS.merge(action: '')

    def short_delete_link(object)
      object_link object, SHORT_DELETE_LINK_OPTIONS
    end

    def short_edit_link(object)
      object_link object, SHORT_EDIT_LINK_OPTIONS
    end

    def short_goto_link(url)
      value_or_sign(url, '') do |value|
        link_to '', value, class: 'goto_link', target: '_blank',
                           title: ::I18n.t('eac_rails_utils.links.goto_url', url: value.to_s),
                           rel: 'noopener'
      end
    end

    def short_show_link(object)
      object_link object, SHORT_SHOW_LINK_OPTIONS
    end

    def short_detail_link(object)
      object_link object, SHORT_DETAIL_LINK_OPTIONS
    end

    require_sub __FILE__, require_mode: :kernel
  end
end
