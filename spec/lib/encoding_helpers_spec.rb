require "rails_helper"

RSpec.describe EncodingHelpers do
  before(:each) do
    @dummy = Class.new
    @dummy.extend(EncodingHelpers)
  end

  describe "encode_as_utf8" do
    it "forces utf-8 encoding for non-utf-8 encoded string usernames" do
      string = "derp-1".force_encoding("ISO-8859-1")
      expect(string.encoding.name).to eq("ISO-8859-1")

      @dummy.encode_as_utf8!(string)

      expect(string.encoding.name).to eq("UTF-8")
    end

    it "replaces non-utf-8-encodable characters with empty strings" do
      string = "deŒrp".force_encoding("ASCII-8BIT")
      expect(string.encoding.name).to eq("ASCII-8BIT")

      @dummy.encode_as_utf8!(string)

      expect(string).to eq("derp")
      expect(string.encoding.name).to eq("UTF-8")
    end
  end
end
