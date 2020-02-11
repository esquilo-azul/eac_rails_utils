# frozen_string_literal: true

require 'htmlbeautifier'

module Eac
  class Htmlbeautifier
    def self.beautify(string)
      ::HtmlBeautifier.beautify(string, tab_stops: 2) + "\n"
    end

    def self.file_beautified?(file)
      input = File.read(file)
      input == beautify(input)
    end

    def self.beautify_file(file)
      input = File.read(file)
      output = beautify(input)
      if input == output
        false
      else
        File.write(file, output)
        true
      end
    end
  end
end
