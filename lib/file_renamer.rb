
require_relative 'path'
require 'byebug'

class FileRenamer
  SLASH = Gem.win_platform? ? '\\' : '/'
  FILENAME_REGEXP = /^[a-zA-Z_0-9 -]+$/ 
  EXTENSION_REGEXP = /^[a-zA-Z0-9]{1,4}$/

  attr_reader :params, :paths 

  def self.rename!(params)
    session = FileRenamer.new(params)
    session.get_paths
    session.rename_files
  end  

  def initialize(params)
    @params = params 
    @paths = []
  end 

  def get_paths
    params_correction!

    Dir["#{params[:dir]}*"].each do |path|
      @paths << Path.new(path, params) 
    end 
  end 

  def rename_files
    i = 0
    @paths.each do |p|
      if p.correct_path?
        p.rename_file!(i)
        i+=1
      end                          
    end
  end 

  private 

  def params_correction!
    abort "Directory must exist!" unless self.params[:dir]
    abort "New name must exist!" unless self.params[:name]

    correct_dir
    correct_name
    correct_prefix
    correct_ext

    abort "Directory must exist!" unless self.params[:dir]
    abort "New name must exist!" unless self.params[:name]
  end 

  def correct_dir
    @params[:dir] << SLASH unless @params[:dir][-1] == SLASH 
    
    unless File.directory?(@params[:dir])
      @params[:dir] = nil 
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
