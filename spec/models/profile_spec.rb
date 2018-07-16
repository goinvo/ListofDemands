require "rails_helper"

RSpec.describe Profile do
  before(:each) do
    @experience = BasicLodExperience.new
    @user = @experience.arlington_user
    @profile = @user.profile

    @invalid_characters = "Username #{I18n.t("activerecord.errors.models.profile.attributes.username.invalid_characters")}"
    @username_taken = "Username has already been taken"
  end

  describe "save" do
    it "allows alpha-numeric chars, hyphens, and underscores for usernames" do
      valid_usernames = ["derp", "1derp", "derp1", "-derp", "derp-", "_derp", "derp_", "1-derp", "derp-1"]

      valid_usernames.each do |valid_username|
        @profile.username = valid_username
        @profile.save

        expect(@profile.errors.full_messages).to be_empty
      end
    end

    it "disallows usernames to be only a number, symbol, or number and symbol" do
      invalid_usernames = ["0", "1", "123456789", "-0", "0-", "_", "-", "867-5309"]

      invalid_usernames.each do |invalid_username|
        @profile.username = invalid_username
        @profile.save

        expect(@profile.errors.full_messages).to include(@invalid_characters)
      end
    end

    it "disallows usernames with whitespace" do
      invalid_usernames = [" ", "Bob Derp", " derp", "derp  "]

      invalid_usernames.each do |invalid_username|
        @profile.username = invalid_username
        @profile.save

        expect(@profile.errors.full_messages).to include(@invalid_characters)
      end
    end

    it "disallows usernames with symbols and characters not in alphanumeric range, hyphens, or underscores" do
      invalid_usernames = ["derp!", ".derp", "$", "~", "%(d3-rp)%", "demands/", "/demands", "¯\_(ツ)_/¯", "¯\\_(ツ)_/¯", "💯"]

      invalid_usernames.each do |invalid_username|
        @profile.username = invalid_username
        @profile.save

        expect(@profile.errors.full_messages).to include(@invalid_characters)
      end
    end

    it "calls utf-8 encoding function on usernames" do
      @profile.username = "derp-1"
      expect(@profile).to receive(:encode_username)

      @profile.save
    end

    it "disallows identical usernames, including case-insensitivity" do
      username = "derp"
      @user.profile.username = username
      @user.save

      user2 = @experience.boxford_user
      user2.profile.username = username
      user2.save

      expect(user2.profile.errors.full_messages).to include(@username_taken)

      user2.profile.username = username.capitalize
      user2.save

      expect(user2.profile.errors.full_messages).to include(@username_taken)
    end

    it "disallows username matching an existing User UUID" do
      username = @user.uuid

      user2 = @experience.boxford_user
      user2.profile.username = username
      user2.save

      expect(user2.profile.errors.full_messages).to include(@username_taken)
    end
  end
end
