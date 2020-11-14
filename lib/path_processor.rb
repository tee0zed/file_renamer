# frozen_string_literal: true

require_relative 'name_alterer'
require_relative 'params_corrector'

module FileRenamer
  class PathProcessor
    attr_accessor :counter

    attr_reader   :name_alterer,
                  :extension,
                  :name,
                  :prefix,
                  :directory,
                  :paths

    def self.run!(args = {})
      self.new(args).rename_files!
    end

    def initialize(args)
      params       = args[:corrected_params] || ParamsCorrector.new.corrected_params(args[:params])

      @extension    = params[:ext]
      @name         = params[:name]
      @directory    = params[:dir]
      @prefix       = params[:prefix]

      @name_alterer = args.fetch(:name_alterer, NameAlterer.new)
      @paths        = paths
      @counter      = 0
    end

    def rename_files!
      paths.each do |path|
        process_path(path) if should_be_renamed?(path)
      end
    end

    private

    def process_path(path)
      old_filename = sliced_filename(path)
      renamed_filename = name_alterer.renamed_filename({ filename: old_filename,
                                                         number: counter,
                                                         new_name: name })

      renamed_path = renamed_path(path, old_filename, renamed_filename)

      rename_file!(path, renamed_path)
      self.counter += 1
    end

    def rename_file!(path, renamed_path)
      File.rename(path, renamed_path)
    end

    def renamed_path(path, filename, new_filename)
      path.gsub(filename, new_filename)
    end

    def should_be_renamed?(path)
      matches_pattern?(path) && is_file?(path)
    end

    def paths
      Dir["#{directory}*"].sort
    end

    def matches_pattern?(path)
      sliced_filename(path).match?(Regexp.new("^#{prefix}.*#{extension}$"))
    end

    def is_file?(path)
      !File.directory?(path)
    end

    def sliced_filename(path)
      path.slice(%r{([^/|\\]+$)})
    end
  end
end
