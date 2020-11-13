require_relative 'name_alterer'
require_relative 'params_corrector'

module FileRenamer
  class PathProcessor

    attr_accessor :paths,
                  :counter

    attr_reader   :name_alterer,
                  :params_corrector,
                  :extension,
                  :name,
                  :prefix,
                  :directory

    def initialize(args = {})
      @params_corrector = args.fetch(:params_corrector, ParamsCorrector)
      @name_alterer  = args.fetch(:name_alterer, NameAlterer)

      init_corrected_params(args[:params])

      @paths = get_paths
      @counter = 0
    end

    def rename_files!
      paths.each do |path|
        if should_be_renamed?(path)
          process_path(path)
        end
      end
    end

    private

    def init_corrected_params(params)
      params = params_corrector.new.corrected_params(params)

      @extension = params[:ext]
      @name      = params[:name]
      @directory = params[:dir]
      @prefix    = params[:prefix]
    end

    def process_path(path)
      old_filename = slice_filename(path)
      renamed_filename = name_alterer.new.renamed_filename({ filename: old_filename,
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

    def get_paths
      Dir["#{directory}*"].sort
    end

    def matches_pattern?(path)
      slice_filename(path).match?(Regexp.new("^#{prefix}.*#{extension}$"))
    end

    def is_file?(path)
      !File.directory?(path)
    end

    def slice_filename(path)
      path.slice(/([^\/|\\]+$)/)
    end
  end
end
