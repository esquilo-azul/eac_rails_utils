# frozen_string_literal: true
module Eac
  module Listable
    extend ActiveSupport::Concern

    included do
      extend(::Eac::Listable::ClassMethods)
      include(::Eac::Listable::InstanceMethods)
    end

    module ClassMethods
      def lists
        @lists ||= ::Eac::Listable::Lists.new(self)
      end
    end

    module InstanceMethods
      LISTABLE_INSTANCE_VALUE_METHODS = %w(label description).freeze

      def method_missing(name, *args, &block)
        list, method = parse_method(name)
        list && method ? list.instance_value(self).send(method) : super
      end

      def respond_to?(name, include_all = false)
        list, method = parse_method(name)
        list && method ? true : super
      end

      private

      def parse_method(method)
        self.class.lists.acts_as_listable_items.each do |item, list|
          LISTABLE_INSTANCE_VALUE_METHODS.each do |m|
            return [list, m] if method.to_s == "#{item}_#{m}"
          end
        end
        [nil, nil]
      end
    end

    class Lists
      attr_reader :source

      def initialize(source)
        @source = source
      end

      def add_integer(item, *labels)
        check_acts_as_listable_new_item(item)
        acts_as_listable_items[item] = ::Eac::Listable::IntegerList.new(
          self, item, labels
        )
      end

      def add_string(item, *labels)
        check_acts_as_listable_new_item(item)
        acts_as_listable_items[item] = ::Eac::Listable::StringList.new(
          self, item, labels
        )
      end

      def method_missing(name, *args, &block)
        list = find_list_by_method(name)
        list ? list : super
      end

      def respond_to?(name, include_all = false)
        find_list_by_method(name) || super
      end

      def acts_as_listable_items
        @acts_as_listable_items ||= ActiveSupport::HashWithIndifferentAccess.new
      end

      private

      def check_acts_as_listable_new_item(item)
        return unless acts_as_listable_items.key?(item)
        raise "Item já adicionado anteriormente: #{item} em #{self} " \
          "(#{acts_as_listable_items.keys})"
      end

      def find_list_by_method(method)
        acts_as_listable_items.each do |item, list|
          return list if method.to_sym == item.to_sym
        end
        nil
      end
    end

    class List
      attr_reader :item

      def initialize(lists, item, labels)
        @lists = lists
        @item = item
        @values = build_values(labels)
        apply_constants
      end

      def values
        @values.values.map(&:value)
      end

      def options
        @values.values.map { |v| [v.label, v.value] }
      end

      def method_missing(name, *args, &block)
        list = find_list_by_method(name)
        list ? list : super
      end

      def respond_to?(name, include_all = false)
        find_list_by_method(name) || super
      end

      def i18n_key
        "eac.listable.#{class_i18n_key}.#{item}"
      end

      def instance_value(instance)
        v = instance.send(item)
        return @values[v] if @values.key?(v)
        raise "List value unkown: #{v} (Source: #{@lists.source}, Item: #{item})"
      end

      private

      def class_i18n_key
        @lists.source.name.underscore.to_sym
      end

      def find_list_by_method(method)
        @values.values.each do |v|
          return v if method.to_s == "value_#{v.key}"
        end
        nil
      end

      def constants
        labels.each_with_index.map { |v, i| ["#{item.upcase}_#{v.upcase}", values[i]] }
      end

      def apply_constants
        @values.values.each do |v|
          @lists.source.const_set(v.constant_name, v.value)
        end
      end

      def build_values(labels)
        vs = {}
        parse_labels(labels).each do |value, key|
          v = Value.new(self, value, key)
          vs[v.value] = v
        end
        vs
      end
    end

    class Value
      attr_reader :value, :key

      def initialize(list, value, key)
        @list = list
        @value = value
        @key = key
      end

      def to_s
        "I: #{@list.item}, V: #{@value}, K: #{@key}"
      end

      def constant_name
        "#{@list.item}_#{@key}".gsub(/[^a-z0-9_]/, '_').gsub(/_+/, '_')
                               .gsub(/(?:\A_|_\z)/, '').upcase
      end

      def label
        translate('label')
      end

      def description
        translate('description')
      end

      private

      def translate(translate_key)
        ::I18n.t("#{@list.i18n_key}.#{@key}.#{translate_key}")
      end
    end

    class IntegerList < ::Eac::Listable::List
      protected

      def parse_labels(labels)
        if labels.first.is_a?(Hash)
          Hash[labels.first.map { |k, v| [k.to_i, v.to_s] }]
        else
          Hash[labels.each_with_index.map { |v, i| [i + 1, v.to_s] }]
        end
      end

      def build_value(index, _key)
        index + 1
      end
    end

    class StringList < ::Eac::Listable::List
      protected

      def parse_labels(labels)
        if labels.first.is_a?(Hash)
          Hash[labels.first.map { |k, v| [k.to_s, v.to_s] }]
        else
          Hash[labels.map { |v| [v.to_s, v.to_s] }]
        end
      end
    end
  end
end
