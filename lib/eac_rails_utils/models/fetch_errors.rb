# frozen_string_literal: true

module EacRailsUtils
  module Models
    module FetchErrors
      # Adiciona as mensagens de erro de record. As mensagens de uma coluna X em record
      # serão adicionadas na coluna X em self. Se options[:default_column] for especificado
      # as mensagens da coluna X de record em que X não existe em self serão adicionadas
      # na coluna options[:default_column].
      # Um array de colunas pode ser passado em options[:skip] de colunas em record que não
      # terão suas falhas adicionadas.
      def fetch_record_errors(record, options = {})
        record.errors.keys.each do |column| # rubocop:disable Rails/DeprecatedActiveModelErrorsMethods
          fetch_column_errors(record, column, column, options)
        end
      end

      # Similar a fetch_record_errors, mas torna possível especificar, através de mapping,
      # colunas-alvo em self com nomes diferentes das colunas-fonte em record.
      # mapping tem o formato { record_column => self_column }.
      def fetch_record_errors_by_mapping(record, mapping, options = {})
        mapping.each do |record_column, self_column|
          fetch_column_errors(record, record_column, self_column, options)
        end
      end

      def fetch_column_errors(record, record_column, self_column, options = {})
        return if options[:skip]&.include?(record_column)

        record.errors[record_column].each do |message|
          fetch_error_column_message(self_column, message, options[:default_column],
                                     "#{record.class.human_attribute_name(record_column)}: ")
        end
      end

      # Verifica se uma coluna existe.
      def column?(column)
        respond_to?(column) && respond_to?("#{column}=")
      end

      def save_or_raise
        raise "Falha ao tentar salvar #{self.class.name}: #{errors_to_string}" unless save

        self
      end

      private

      def fetch_error_column_message(column, message, default_column, default_column_message_prefix)
        build_self_columns_messages(column, message, default_column,
                                    default_column_message_prefix).each do |k, v|
          if column?(k)
            add_error_message(k, v)
            break
          end
        end
      end

      # Adiciona uma mensagem de erro a uma coluna somente se a coluna
      # ainda não a possui
      def add_error_message(column, message)
        return if errors[column].include?(message)

        errors.add(column, message)
      end

      # Produz uma lista de campos-mensagens, em ordem de preferência,
      # que podem receber uma mensagem de falha.
      def build_self_columns_messages(column, message, default_column,
                                      default_column_message_prefix)
        r = { column => message }
        m = /^(.+)_id$/.match(column)
        if m
          r[m[1]] = message
        else
          r["#{column}_id"] = message
        end
        r[default_column] = "#{default_column_message_prefix}#{message}" if default_column
        r
      end

      def errors_to_string
        b = ''
        errors.messages.each do |field, messages|
          b += ' / ' if b != ''
          b += field.to_s + ': ' + messages.to_s
        end
        b
      end
    end
  end
end
