# frozen_string_literal: true

module EacRailsUtils
  module Rspec
    module Setup
      module ModelsUtils
        def model_record_attribute_test(record_variable, attribute, valid, value)
          context("when #{record_variable}.#{attribute} == #{value}") do
            before do
              send(record_variable).send("#{attribute}=", value)
            end

            it "#{record_variable} should be #{'not ' unless valid}valid" do
              expect(send(record_variable).valid?).to(send("be_#{valid ? 'truthy' : 'falsy'}"),
                                                      -> { send(record_variable).errors.messages })
            end
          end
        end

        def model_record_values_attribute_test(record_variable, attribute, valid, values)
          values.each do |value|
            model_record_attribute_test(record_variable, attribute, valid, value)
          end
        end

        def model_record_valid_invalid_values_attribute_test(record_variable, attribute,
                                                             valid_values, invalid_values)
          {
            false => invalid_values,
            true => valid_values
          }.each do |valid, values|
            model_record_values_attribute_test(record_variable, attribute, valid, values)
          end
        end
      end
    end
  end
end
