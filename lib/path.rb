class Path
  FILENAME_REGEX = /([^\/|\\]+$)/

  attr_accessor :path, :prefix, :ext, :new_name

  def initialize(path, new_name, prefix, ext)
    @path = path
    @new_name = new_name 
    @prefix = prefix
    @ext = ext
  end 

  def correct_path?
    @path.slice(FILENAME_REGEX)
    .match?(Regexp.new("^#{prefix}.*#{ext}$"))
  end 

  def rename_file!
    File.rename(@path, renamed_path)
  end 

  private 

  def renamed_path 
    filename = @path.slice(FILENAME_REGEX)
    new_name = filename.gsub(/^\w+./, "#{@new_name}.")

    @path.gsub(filename, new_name)
  end 
end 