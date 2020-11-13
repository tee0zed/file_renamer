
module FileRenamer
  class NameAlterer

    attr_reader :filename,
                :number,
                :name

    def initialize
      @filename
      @number
      @name
    end

    def renamed_filename(args)
      init_params(args)
      name_with_extension
    end

    private

    def init_params(args)
      @filename = args[:filename]
      @number   = args[:number]
      @name     = args[:new_name]
    end

    def name_with_extension
      filename.gsub(/^\w+./, "#{numbered_name}.")
    end

    def numbered_name
      number.zero? ? "#{name}" : "#{name}_#{number}"
    end
  end 
end
