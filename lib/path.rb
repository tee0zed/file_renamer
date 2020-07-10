class Path
  def initialize(path, new_name, prefix, ext)
    @path = path
    @new_name = new_name 
    @prefix = prefix
    @ext = ext
  end 

  def correct_file? 
    regex = Regexp.new("^#{@prefix}.*#{@ext}$")
    return @path if @path.match?(regex)
    nil 
  end 

  def rename_file!
    File.rename(@path, )
  end 
end 