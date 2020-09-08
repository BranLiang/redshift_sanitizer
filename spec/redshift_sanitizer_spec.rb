RSpec.describe RedshiftSanitizer do
  it "do nothing unless target if a string" do
    expect(RedshiftSanitizer.clean(1)).to eq(1)
    expect(RedshiftSanitizer.clean(true)).to eq(true)
    expect(RedshiftSanitizer.clean(nil)).to eq(nil)
  end

  # https://en.wikipedia.org/wiki/UTF-8
  it "remove invalid UTF-8 characters" do
    invalid_utf8 = "hello bran\255"
    expect(RedshiftSanitizer.clean(invalid_utf8)).to eq("hello bran")
  end

  it "limit the varchar length if provide length limit" do
    overlength_string = "asdfghjkl"
    chinese_char = "abc你好啊"
    limit = 4
    expect(RedshiftSanitizer.clean(overlength_string, limit: limit)).to eq("asdf")
    expect(RedshiftSanitizer.clean(chinese_char, limit: limit)).to eq("abc")
  end

  it "remove default delimeter" do
    text_with_delimeter = "hello^world"
    expect(RedshiftSanitizer.clean(text_with_delimeter)).to eq("helloworld")
  end

  it "remove configurable delimeter" do
    text_with_delimeter = "hello^world~hey"
    RedshiftSanitizer.configure do |config|
      config.delimeter = "~"
      config.replace = "?"
    end
    expect(RedshiftSanitizer.clean(text_with_delimeter)).to eq("hello^world?hey")
    # reset
    RedshiftSanitizer.configure do |config|
      config.delimeter = "^"
      config.replace = ""
    end
  end

  it "remove last character of row" do
    text_with_eof = "hello\nworld\n"
    expect(RedshiftSanitizer.clean(text_with_eof)).to eq("helloworld")
  end

  it "remove null character" do
    char_with_null = "hello\0worldhey\u0000no\x00way"
    expect(RedshiftSanitizer.clean(char_with_null)).to eq("helloworldheynoway")
  end

  it "remove single start character" do
    char_with_valid_quotes = "'Hello world'"
    expect(RedshiftSanitizer.clean(char_with_valid_quotes)).to eq("Hello world")

    char_with_invalid_quotes_1 = "'Hello world"
    expect(RedshiftSanitizer.clean(char_with_invalid_quotes_1)).to eq("Hello world")

    char_with_invalid_quotes_2 = "\"Hello world'''''"
    expect(RedshiftSanitizer.clean(char_with_invalid_quotes_2)).to eq("Hello world")
  end

  it "remove quotes inside string" do
    char_with_valid_quotes = "Hello\" world"
    expect(RedshiftSanitizer.clean(char_with_valid_quotes)).to eq("Hello world")

    char_with_invalid_quotes_1 = "Hello' world"
    expect(RedshiftSanitizer.clean(char_with_invalid_quotes_1)).to eq("Hello world")
  end

  it "encode chinese correctly" do
    char_with_chinese = "你好"
    expect(RedshiftSanitizer.clean(char_with_chinese)).to eq("你好")
  end
end
