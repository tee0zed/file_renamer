require 'byebug'

module FileRenamer
  class Path
    FILENAME_REGEX = /([^\/|\\]+$)/

    @@counter = 0 
    
    attr_reader :path, :prefix, :ext, :new_name

    def self.get_count 
      @@counter 
    end 

    def self.reset_counter
      @@counter = 0
    end 

    def initialize(path, params)
      @path = path
      @new_name = params[:name] 
      @prefix = params[:prefix]
      @ext = params[:ext]
    end 

    def correct_path?
      @path.slice(FILENAME_REGEX)
      .match?(Regexp.new("^#{prefix}.*#{ext}$")) && 
      !File.directory?(@path)
    end 

    def rename_file!
      File.rename(@path, renamed_path(@@counter))
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
      
      name << '.' if filename.match?('\.')

      new_name = filename.gsub(/^\w+./, "#{name}")

      @path.gsub(filename, new_name)
    end 
  end 
end
