require 'byebug'

class Path
  FILENAME_REGEX = /([^\/|\\]+$)/

  @@counter = 0 
  
  attr_reader :path, :prefix, :ext, :new_name

  def self.get_count 
    @@counter 
  end 

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
    @@counter += 1 
  end 

  private 

  def renamed_path(num)
    filename = @path.slice(FILENAME_REGEX)

    name = 
    if num == 0 
      "#{@new_name}"
    else 
      "#{@new_name}_#{num}"
    end 
      
    new_name = filename.gsub(/^\w+./, "#{name}.")

    @path.gsub(filename, new_name)
  end 
end 
