require "redshift_sanitizer/version"
require "redshift_sanitizer/configuration"

module RedshiftSanitizer
  extend self
  attr_accessor :configuration

  class Error < StandardError; end

  def configure
    yield(configuration)
  end

  def configuration
    @configuration ||= Configuration.new
  end

  def clean(text, **options)
    # Ignore non string value
    return text unless text.is_a? String

    # Limit the length if needed, value should be the redshift VARCHAR limit
    if options[:limit]
      text = text.byteslice(0, options[:limit])
    end

    # Remove invalid UTF-8 character
    text = text.encode('UTF-8', invalid: :replace, undef: :replace, replace: configuration.replace)

    # Remove delimeter
    text = text.gsub(configuration.delimeter, configuration.replace)

    # Remove end_of_field (eof)
    text = text.gsub(configuration.eof, configuration.replace)

    # Remove nulls
    text = text.gsub("\u0000", configuration.replace)

    # No surrounding quote
    text = text.gsub(/^(\"|\')+/, '')
               .gsub(/(\"|\')+$/, '')

    text
  end
end
