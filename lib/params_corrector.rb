# frozen_string_literal: true

module FileRenamer
  class ParamsCorrector
    SLASH = Gem.win_platform? ? '\\' : '/'
    FILENAME_REGEXP = /^[a-zA-Z_0-9-]+$/.freeze
    EXTENSION_REGEXP = /^[a-zA-Z0-9_.]{1,6}$/.freeze

    attr_accessor :params

    def initialize
      @params
    end

    def corrected_params(params)
      init_params(params)
      params_correction!
      self.params
    end

    def init_params(params)
      self.params = params
    end

    private

    def params_correction!
      params[:dir]    = correct_dir(params[:dir])
      params[:name]   = correct_name(params[:name])
      params[:prefix] = correct_prefix(params[:prefix])
      params[:ext]    = correct_ext(params[:ext])
    end

    def correct_dir(dir)
      if dir.nil?
        Dir.pwd + SLASH
      elsif File.directory?(dir)
        dir += SLASH if dir[-1] != SLASH
        dir
      else
        raise StandardError.new "Directory must exist!"
      end
    end

    def correct_name(name)
      if name.to_s.match?(FILENAME_REGEXP)
        name.strip.chomp
      else
        raise StandardError.new "Incorrect name!"
      end
    end

    def correct_prefix(prefix)
      prefix.to_s.strip
    end

    def correct_ext(ext)
      if ext.to_s.match?(EXTENSION_REGEXP)
        ext[0] == '.' ? ext : ext.prepend('.')
      end
    end
  end
end
