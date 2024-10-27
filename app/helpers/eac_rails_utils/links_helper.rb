# frozen_string_literal: true

module EacRailsUtils
  module LinksHelper
    SHORT_DELETE_LINK_OPTIONS = {
      action: '', class: 'delete_link', method: :delete, target: '_blank',
      title_translation: 'eac_rails_utils.links.delete_object',
      confirm_translation: 'eac_rails_utils.links.delete_confirm'
    }.freeze
    SHORT_EDIT_LINK_OPTIONS = {
      action: 'edit', class: 'edit_link', target: '_blank',
      title_translation: 'eac_rails_utils.links.edit_object'
    }.freeze
    SHORT_DETAIL_SHOW_LINK_OPTIONS = {
      class: 'show_link', target: '_blank',
      title_translation: 'eac_rails_utils.links.show_object'
    }.freeze
    SHORT_DETAIL_LINK_OPTIONS = SHORT_DETAIL_SHOW_LINK_OPTIONS.merge(action: 'detail')
    SHORT_SHOW_LINK_OPTIONS = SHORT_DETAIL_SHOW_LINK_OPTIONS.merge(action: '')

    def short_delete_link(object)
      short_object_link object, SHORT_DELETE_LINK_OPTIONS
    end

    def short_edit_link(object)
      short_object_link object, SHORT_EDIT_LINK_OPTIONS
    end

    def short_goto_link(url)
      value_or_sign(url, '') do |value|
        link_to '', value, class: 'goto_link', target: '_blank',
                           title: ::I18n.t('eac_rails_utils.links.goto_url', url: value.to_s),
                           rel: 'noopener'
      end
    end

    def short_show_link(object)
      short_object_link object, SHORT_SHOW_LINK_OPTIONS
    end

    def short_detail_link(object)
      short_object_link object, SHORT_DETAIL_LINK_OPTIONS
    end

    private

    def short_object_link(object, options = {})
      object_link(object, options.merge(name: ''))
    end

    require_sub __FILE__, require_mode: :kernel
  end
end
