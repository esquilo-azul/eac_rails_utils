# frozen_string_literal: true

module Eac
  module CommonFormHelper
    class FormBuilder
      module CommonTextFields
        %w[email password text].each do |t|
          class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
            def #{t}_field(field_name, options = {})  # def text_field(field_name, options = {})
              field(field_name, options) do           #   field(field_name, options) do
                input_options = options[:input_options] || {}
                input_options[:class] ||= 'form-control'
                @form.#{t}_field(field_name,          #     @form.text_field(field_name,
                  input_options)              #       class: 'form-control')
              end                                     #   end
            end                                       # end
          RUBY_EVAL
        end
      end
    end
  end
end
