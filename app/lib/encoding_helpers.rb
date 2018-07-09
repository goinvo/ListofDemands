module EncodingHelpers
  def encode_as_utf8!(string)
    # http://graysoftinc.com/character-encodings/ruby-19s-string
    string.encode!(Encoding.find("UTF-8"), { invalid: :replace, undef: :replace, replace: "" })
  end
end
