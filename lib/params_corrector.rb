
module FileRenamer
  class ParamsCorrector

    SLASH = Gem.win_platform? ? '\\' : '/'
    FILENAME_REGEXP = /^[a-zA-Z_0-9 -]+$/
    EXTENSION_REGEXP = /^[a-zA-Z0-9 .]{1,6}$/

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
        nil
      end
    end

    def correct_name(name)
      if "#{name}".match?(FILENAME_REGEXP)
        name.strip.gsub(' ', '_')
      else
        nil
      end
    end

    def correct_prefix(prefix)
      "#{prefix}".strip
    end

    def correct_ext(ext)
      if "#{ext}".match?(EXTENSION_REGEXP)
        ext[0] == '.' ? ext : ext.prepend('.')
      else
        nil
      end
    end
  end
end
