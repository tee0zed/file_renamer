class Path
  FILENAME_REGEX = /([^\/|\\]+$)/
  
  attr_reader :path, :prefix, :ext, :new_name

  def initialize(path, params)
    @path = path
    @new_name = params[:name] 
    @prefix = params[:prefix]
    @ext = params[:ext]
  end 

  def correct_path?
    @path.slice(FILENAME_REGEX)
    .match?(Regexp.new("^#{prefix}.*#{ext}$"))
  end 

  def rename_file!(n)
    File.rename(@path, renamed_path(n))
  end 

  private 

  def renamed_path(n)
    filename = @path.slice(FILENAME_REGEX)
    new_name = filename.gsub(/^\w+./, "#{n}_#{@new_name}.")

    @path.gsub(filename, new_name)
  end 
end 