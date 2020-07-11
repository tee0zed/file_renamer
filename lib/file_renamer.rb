require_relative 'path'

class FileRenamer
  SLASH = Gem.win_platform? ? '\\' : '/'

  attr_reader :params, :paths 

  def initialize(params)
    @params = params 
    @paths = []
  end 

  def get_paths
    dir = correct_dir
    return dir unless dir 

    params_correction

    Dir["#{dir}*"].each do |path|
      @paths << Path.new(path, params) 
    end 
  end 

  def rename_files!
    @paths.each_with_index do |p, i|
      p.rename_file!(i+1) if p.correct_path?
    end
  end 

  private 

  def params_correction
    correct_name
    correct_prefix
    correct_ext
  end 

  def correct_dir
    @params[:path] << SLASH unless @params[:path][-1] == SLASH 
    
    if File.directory?(@params[:path])
      return @params[:path] 
    end 

    @params[:path] =  nil 
  end

  def correct_name
    if @params[:name] && @params[:name].match?(/^[a-zA-Z_0-9 -]+$/)
      @params[:name] = @params[:name].strip!.gsub(' ', '_') 
    else 
      @params[:name] = nil 
    end 
  end 

  def correct_prefix
    @params[:prefix] = @params[:prefix].strip if @params[:prefix]
  end 

  def correct_ext
    if @params[:ext] && @params[:ext].match?(/^[a-zA-Z0-9]{1,4}$/)
      @params[:ext] = '.' + @params[:ext] unless @params[:ext][0] == '.'
    else 
      @params[:ext] = nil 
    end 
  end 
end 
