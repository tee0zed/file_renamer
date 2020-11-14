# frozen_string_literal: true

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
      @filename = args[:filename]
      @number   = args[:number]
      @name     = args[:new_name]

      name_with_extension
    end

    private

    def name_with_extension
      filename.gsub(/^\w+./, "#{numbered_name}.")
    end

    def numbered_name
      number.zero? ? name.to_s : "#{name}_#{number}"
    end
  end
end
