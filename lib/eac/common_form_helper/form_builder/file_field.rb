# frozen_string_literal: true

module Eac
  module CommonFormHelper
    class FormBuilder
      module FileField
        def file_field(field_name, options = {})
          options = options.dup
          field(field_name, options) do
            form.file_field(field_name, options)
          end
        end
      end
    end
  end
end
