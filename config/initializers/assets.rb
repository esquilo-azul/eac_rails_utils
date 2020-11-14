# frozen_string_literal: true

Rails.application.config.assets.precompile += %w[asc desc].flat_map do |middle|
  ['', '_disabled'].map { |suffix| "sort_#{middle}#{suffix}.png" }
end
Rails.application.config.assets.precompile += %w[sort_both.png]
