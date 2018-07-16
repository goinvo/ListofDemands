require "rails_helper"

RSpec.describe DemandRelationship do
  before(:each) do
    @experience = BasicLodExperience.new
    @user = @experience.arlington_user
  end

  describe "to_param" do
    it "returns username if present" do
      @user.profile.username = "derp"
      @user.save

      expect(@user.to_param).to eq(@user.profile.username)
    end

    it "returns UUID if username is blank" do
      @user.profile.username = ""
      @user.save

      expect(@user.to_param).to eq(@user.uuid)
    end

    it "returns UUID if username is nil" do
      @user.profile.username = nil
      @user.save

      expect(@user.to_param).to eq(@user.uuid)
    end
  end
end
