require "rails_helper"

RSpec.describe DemandRelationship do
  before(:each) do
    @user = create_arlington_user
    @zip = "02476"
    @profile = FactoryBot.create(:profile, user: @user, zip: @zip)
  end

  describe "save" do
    it "allows alpha-numeric chars, hyphens, and underscores" do
      valid_usernames = ["derp", "1derp", "derp1", "-derp", "derp-", "_derp", "derp_", "1-derp", "derp-1"]

      valid_usernames.each do |valid_username|
        @profile.username = valid_username
        @profile.save

        expect(@profile.errors.full_messages).to be_empty
      end
    end

    it "disallows names to be only a number, symbol, or number and symbol" do
      error_msg = "Username Only letters, numbers, hyphens, and underscores are allowed. Must contain at least one letter."
      invalid_usernames = ["0", "1", "123456789", "-0", "0-", "_", "-", "867-5309"]

      invalid_usernames.each do |invalid_username|
        @profile.username = invalid_username
        @profile.save

        expect(@profile.errors.full_messages).to include(error_msg)
      end
    end

    it "disallows symbols and characters not in alphanumeric range, hyphens, or underscores" do
      error_msg = "Username Only letters, numbers, hyphens, and underscores are allowed. Must contain at least one letter."
      invalid_usernames = ["derp!", ".derp", "$", "~", "%(d3-rp)%", "demands/", "/demands", "¯\_(ツ)_/¯", "¯\\_(ツ)_/¯", "💯"]

      invalid_usernames.each do |invalid_username|
        @profile.username = invalid_username
        @profile.save

        expect(@profile.errors.full_messages).to include(error_msg)
      end
    end

    it "calls utf-8 encoding function" do
      @profile.username = "derp-1"
      expect(@profile).to receive(:encode_username)

      @profile.save
    end

    it "forces utf-8 encoding for non-utf-8 encoded strings" do
      username = "derp-1"
      @profile.username = username.force_encoding("ISO-8859-1")
      @profile.save

      expect(@profile.username).to eq(username)
      expect(@profile.username.encoding.name).to eq("UTF-8")
    end
  end
end
