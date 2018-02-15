# frozen_string_literal: true
namespace :eac do
  desc 'Baixa o conteúdo remoto de fixtures'
  task download_fixtures: :environment do
    ::Eac::DownloadFixtures.new(ENV['PREFIX'], ENV['DOWNLOAD'].present?).run
  end
end
