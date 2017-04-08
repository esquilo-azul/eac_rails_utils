# encoding: UTF-8
# frozen_string_literal: true
require 'test_helper'

module Eac
  class ListableTest < ActiveSupport::TestCase
    class Stub
      include ::Eac::Listable

      attr_accessor :inteiro, :cadeia

      lists.add_integer :inteiro, :a, :b, :c
      lists.add_string :cadeia, :a, :b, :c
    end

    setup do
      I18n.locale = 'pt-BR'
    end

    test 'attribute values' do
      assert_equal [1, 2, 3], Stub.lists.inteiro.values
      assert_equal %w(a b c), Stub.lists.cadeia.values
    end

    test 'value instance options' do
      assert_equal [['Inteiro A', 1], ['Inteiro BB', 2], ['Inteiro CCC', 3]],
                   Stub.lists.inteiro.options
      assert_equal [['Cadeia AAA', 'a'], ['Cadeia BB', 'b'], ['Cadeia C', 'c']],
                   Stub.lists.cadeia.options
    end

    test 'constants' do
      assert_equal 1, Stub::INTEIRO_A
      assert_equal 2, Stub::INTEIRO_B
      assert_equal 3, Stub::INTEIRO_C
      assert_equal 'a', Stub::CADEIA_A
      assert_equal 'b', Stub::CADEIA_B
      assert_equal 'c', Stub::CADEIA_C
    end

    test 'values instances' do
      assert Stub.lists.is_a?(::Eac::Listable::Lists)
      assert Stub.lists.inteiro.value_a.is_a?(::Eac::Listable::Value)
      assert Stub.lists.inteiro.value_b.is_a?(::Eac::Listable::Value)
      assert Stub.lists.inteiro.value_c.is_a?(::Eac::Listable::Value)
      assert Stub.lists.cadeia.value_a.is_a?(::Eac::Listable::Value)
      assert Stub.lists.cadeia.value_b.is_a?(::Eac::Listable::Value)
      assert Stub.lists.cadeia.value_c.is_a?(::Eac::Listable::Value)
    end

    test 'value instance label' do
      assert_equal 'Inteiro A', Stub.lists.inteiro.value_a.label
      assert_equal 'Inteiro BB', Stub.lists.inteiro.value_b.label
      assert_equal 'Inteiro CCC', Stub.lists.inteiro.value_c.label
      assert_equal 'Cadeia AAA', Stub.lists.cadeia.value_a.label
      assert_equal 'Cadeia BB', Stub.lists.cadeia.value_b.label
      assert_equal 'Cadeia C', Stub.lists.cadeia.value_c.label
    end

    test 'value instance description' do
      assert_equal 'Inteiro A Descr.', Stub.lists.inteiro.value_a.description
      assert_equal 'Inteiro BB Descr.', Stub.lists.inteiro.value_b.description
      assert_equal 'Inteiro CCC Descr.', Stub.lists.inteiro.value_c.description
      assert_equal 'Cadeia AAA Descr.', Stub.lists.cadeia.value_a.description
      assert_equal 'Cadeia BB Descr.', Stub.lists.cadeia.value_b.description
      assert_equal 'Cadeia C Descr.', Stub.lists.cadeia.value_c.description
    end

    test 'value instance constant name' do
      assert_equal 'INTEIRO_A', Stub.lists.inteiro.value_a.constant_name
      assert_equal 'INTEIRO_B', Stub.lists.inteiro.value_b.constant_name
      assert_equal 'INTEIRO_C', Stub.lists.inteiro.value_c.constant_name
      assert_equal 'CADEIA_A', Stub.lists.cadeia.value_a.constant_name
      assert_equal 'CADEIA_B', Stub.lists.cadeia.value_b.constant_name
      assert_equal 'CADEIA_C', Stub.lists.cadeia.value_c.constant_name
    end

    test 'instance label and descriptions' do
      i = Stub.new
      i.inteiro = Stub::INTEIRO_A
      assert_equal 'Inteiro A', i.inteiro_label
      assert_equal 'Inteiro A Descr.', i.inteiro_description
      i.inteiro = Stub::INTEIRO_B
      assert_equal 'Inteiro BB', i.inteiro_label
      assert_equal 'Inteiro BB Descr.', i.inteiro_description
      i.inteiro = Stub::INTEIRO_C
      assert_equal 'Inteiro CCC', i.inteiro_label
      assert_equal 'Inteiro CCC Descr.', i.inteiro_description
      i.cadeia = Stub::CADEIA_A
      assert_equal 'Cadeia AAA', i.cadeia_label
      assert_equal 'Cadeia AAA Descr.', i.cadeia_description
      i.cadeia = Stub::CADEIA_B
      assert_equal 'Cadeia BB', i.cadeia_label
      assert_equal 'Cadeia BB Descr.', i.cadeia_description
      i.cadeia = Stub::CADEIA_C
      assert_equal 'Cadeia C', i.cadeia_label
      assert_equal 'Cadeia C Descr.', i.cadeia_description
    end
  end
end
