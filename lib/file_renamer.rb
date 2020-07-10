require_relative 'path'

class FileRenamer
  attr_reader :params, :paths 

  def initialize(params)
    @params = params 
    @paths = []
  end 

  def get_paths
    dir = correct_dir

    return nil unless dir 

    params = path_params 

    Dir["#{dir}*"].each do |path|
      @paths << Path.new(path, *params) 
    end 
  end 

  def rename_files!
    @paths.each do |p|
      p.rename_file! 
    end
  end 

  private 

  def path_params
    [correct_name, correct_prefix, correct_ext]
  end 

  def correct_dir
    if @params[:path] && File.directory?(@params[:path])
      @params[:path] << '/' unless @params[:path][-1] == '/'
      return @params[:path]
    end 
  end

  def correct_name
    return @params[:name].gsub(' ', '_') if @params[:name] && @params[:name].match?(/^[a-zA-Z_0-9-]+$/)
  end 

  def correct_prefix
    @params[:prefix].strip if @params[:prefix]
  end 

  def correct_ext
    if @params[:ext] && @params[:ext].match?(/^[a-zA-Z0-9]{1,4}$/)
      return '.' + @params[:ext] if @params[:ext][0] == '.'
    end 
  end 
end 
