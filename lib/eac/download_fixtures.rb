# frozen_string_literal: true

module Eac
  class DownloadFixtures
    def initialize(prefix, download)
      @prefix = prefix
      @prefix = '' if @prefix.blank?
      @download = download
    end

    def run
      url_files.each do |f|
        Rails.logger.info(relative_path(f))
        download(url(f), target(f)) if @download
      end
    end

    private

    def url_files
      files = []
      Dir["#{fixtures_root}/**/*.url"].map do |path|
        files << path if match_pattern(path)
      end
      files
    end

    def match_pattern(path)
      relative_path(path).start_with?(@prefix)
    end

    def fixtures_root
      Rails.root.to_s
    end

    def download(url, target)
      Rails.logger.info "Baixando \"#{url}\"..."
      File.open(target, 'wb') { |file| file.write(Parsers::Base.new(url).content) }
    end

    def url(file)
      File.read(file).strip
    end

    def target(file)
      File.expand_path(File.basename(file, '.url') + '.source.html', File.dirname(file))
    end

    def relative_path(path)
      path.sub(%r{^#{Regexp.quote(fixtures_root)}/}, '')
    end
  end
end
