# frozen_string_literal: true

module EacRailsUtils
  module OpenGraphProtocolHelper
    OGP_META_DEFAULT_PREFIX = 'og'

    def ogp_meta_prefix
      OGP_META_DEFAULT_PREFIX
    end

    def ogp_prefix
      "#{ogp_meta_prefix}: http://ogp.me/ns#"
    end

    def ogp_meta_tags
      ogp_root.children_tags
    end

    def ogp_root
      @ogp_root ||= RootEntry.new(self)
    end

    def ogp_set(data)
      ogp_root.data = data
    end

    class AbstractEntry
      attr_reader :view

      def initialize(view)
        @view = view # rubocop:disable Rails/HelperInstanceVariable
        @children = ::ActiveSupport::HashWithIndifferentAccess.new # rubocop:disable Rails/HelperInstanceVariable
      end

      def child(child_suffix)
        @children[child_suffix] ||= Entry.new(view, self, child_suffix) # rubocop:disable Rails/HelperInstanceVariable
      end

      def children_tags
        view.capture do
          view.concat tag
          @children.values.each do |child| # rubocop:disable Rails/HelperInstanceVariable
            view.concat(child.children_tags)
            view.concat("\n")
          end
        end
      end

      def data=(a_data)
        if a_data.is_a?(::Hash)
          a_data.each { |k, v| child(k).data = v }
        else
          self.content = a_data
        end
      end
    end

    class Entry < AbstractEntry
      attr_reader :parent, :suffix

      def initialize(view, parent, suffix)
        super view
        @parent = parent # rubocop:disable Rails/HelperInstanceVariable
        @suffix = suffix # rubocop:disable Rails/HelperInstanceVariable
      end

      def components
        (parent.present? ? parent.components : []) + [suffix]
      end

      def content
        view.content_for content_for_key
      end

      def content=(a_content)
        view.content_for content_for_key, a_content.to_s
      end

      def content?
        view.content_for? content_for_key
      end

      def content_for_key
        "ogp_#{components.join('_')}"
      end

      def property_value
        "#{view.ogp_meta_prefix}:#{components.join(':')}"
      end

      def tag
        return ::ActiveSupport::SafeBuffer.new unless content?

        view.tag(:meta, prefix: view.ogp_prefix, property: property_value, content: content)
      end
    end

    class RootEntry < AbstractEntry
      def components
        []
      end

      def content=(_a_content)
        raise 'Root OGP entry cannot have content'
      end

      def tag
        ::ActiveSupport::SafeBuffer.new
      end
    end
  end
end
