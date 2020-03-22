# frozen_string_literal: true

module Eac
  class CpfValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      return if Cpf.new(value).valid?

      record.errors[attribute] << (options[:message] ||
          'CPF inválido (9 caracteres, somente dígitos)')
    end

    class Cpf
      def initialize(input)
        @input = input
      end

      def valid?
        return false if input_invalid?

        digito_verificador1_calculo == values[9] && digito_verificador2_calculo == values[10]
      end

      private

      attr_reader :input

      def input_invalid?
        input.nil? || digits.length != 11 || digits.length != input.length || null?
      end

      def null?
        %w[12345678909 11111111111 22222222222 33333333333 44444444444 55555555555
           66666666666 77777777777 88888888888 99999999999 00000000000].member?(digits.join)
      end

      def digits
        @digits ||= input.scan(/[0-9]/)
      end

      def values
        @values ||= digits.collect(&:to_i)
      end

      def digito_verificador1_calculo
        digito_verificador_calculo(9, 10)
      end

      def digito_verificador2_calculo
        digito_verificador_calculo(10, 11)
      end

      def digito_verificador_calculo(valores_count, coeficiente_inicial)
        s = 0
        c = coeficiente_inicial
        (0..valores_count - 1).each do |i|
          s += values[i] * c
          c -= 1
        end
        s -= (11 * (s / 11))
        [0, 1].include?(s) ? 0 : 11 - s
      end
    end
  end
end
