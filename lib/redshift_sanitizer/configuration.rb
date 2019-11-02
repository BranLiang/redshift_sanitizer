module RedshiftSanitizer
  class Configuration
    attr_accessor :delimeter, :replace, :eof

    def initialize
      @delimeter = "^"
      @replace = ""
      @eof = "\n"
    end
  end
end
