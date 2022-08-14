# frozen_string_literal: true

module EacRailsUtils
  module UrlHelper
    class << self
      # Returns the relative root url of the application
      def relative_url_root
        if ::ActionController::Base.respond_to?('relative_url_root')
          ::ActionController::Base.relative_url_root.to_s
        else
          ::ActionController::Base.config.relative_url_root.to_s
        end
      end

      # Sets the relative root url of the application
      def relative_url_root=(arg)
        if ::ActionController::Base.respond_to?('relative_url_root=')
          ::ActionController::Base.relative_url_root = arg
        else
          ::ActionController::Base.config.relative_url_root = arg
        end
      end
    end
  end
end
