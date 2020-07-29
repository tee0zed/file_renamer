require_relative 'file_renamer/version.rb'
require_relative 'path'

module FileRenamer
  class Renamer
    SLASH = Gem.win_platform? ? '\\' : '/'
    FILENAME_REGEXP = /^[a-zA-Z_0-9 -]+$/ 
    EXTENSION_REGEXP = /^[a-zA-Z0-9]{1,4}$/

    attr_reader :params, :paths 

    def self.rename!(params)
      session =  FileRenamer::Renamer.new(params)
      session.get_paths
      session.rename_files
    end  

    def initialize(params)
      @params = params 
      @paths = []
    end 

    def get_paths
      params_correction!

      Dir["#{params[:dir]}*"].sort.each do |path|
        @paths << FileRenamer::Path.new(path, params) 
      end 
    end 

    def rename_files
      @paths.each { |p| p.rename_file! if p.correct_path? }
    end 

    private 

    def params_correction!
      correct_dir

      abort "New name must exist!" unless params[:name]
      correct_name
      
      correct_prefix
      correct_ext
      
      abort "Incorrect name!" unless @params[:name]
      abort "Directory must exist!" unless @params[:dir]
    end 

    def correct_dir
      if @params[:dir].nil? 
        @params[:dir] = Dir.pwd
        @params[:dir] << SLASH
      else 
        @params[:dir] << SLASH unless @params[:dir][-1] == SLASH 
        @params[:dir] = nil unless File.directory?(@params[:dir])
      end 
    end

    def correct_name
      if @params[:name] && @params[:name].match?(FILENAME_REGEXP)
        @params[:name] = @params[:name].strip.gsub(' ', '_') 
      else 
        @params[:name] = nil 
      end 
    end 

    def correct_prefix
      @params[:prefix] = @params[:prefix].strip if @params[:prefix]
    end 

    def correct_ext
      if @params[:ext] && @params[:ext].match?(EXTENSION_REGEXP)
        @params[:ext] = '.' + @params[:ext] unless @params[:ext][0] == '.'
      else 
        @params[:ext] = nil 
      end 
    end 
  end 
end
