require "rails_helper"
require "constants"

RSpec.describe DemandForm do
  before(:each) do
    @user = create_arlington_user
    @profile_params = attributes_for(:profile, :arlington)
  end

  describe "initialize" do
    it "sets @user" do
      form = UpdateProfileForm.new(@user, {})
      expect(form.user).to eq(@user)
    end
  end

  describe "submit" do
    it "updates a profile with valid profile attributes" do
      @profile_params[:private_user] = true
      form = UpdateProfileForm.new(@user, profile_attributes: @profile_params)
      form.submit

      expect(@user.profile.username).to eq(@profile_params[:username])
      expect(@user.profile.name).to eq(@profile_params[:name])
      expect(Date.parse(@user.profile.date_of_birth.to_s)).to eq(Date.parse(@profile_params[:date_of_birth]))
      expect(@user.profile.gender).to eq(@profile_params[:gender])
      expect(@user.profile.political_party).to eq(@profile_params[:political_party])
      expect(@user.profile.address1).to eq(@profile_params[:address1])
      expect(@user.profile.address2).to eq(@profile_params[:address2])
      expect(@user.profile.city).to eq(@profile_params[:city])
      expect(@user.profile.state).to eq(@profile_params[:state])
      expect(@user.profile.zip).to eq(@profile_params[:zip])
      expect(@user.profile.private_user).to eq(true)
    end

    it "requires a zip" do
      @profile_params[:zip] = ""
      form = UpdateProfileForm.new(@user, profile_attributes: @profile_params)
      form.user.profile.assign_attributes(@profile_params)

      expect(form.user.valid?).to be(false)
    end

    it "requires a name" do
      @profile_params[:name] = ""
      form = UpdateProfileForm.new(@user, profile_attributes: @profile_params)
      form.user.profile.assign_attributes(@profile_params)

      expect(form.user.valid?).to be(false)
    end

    it "rescues from non-unique username if validation doesn't catch it" do
      expect_any_instance_of(User).to receive(:save!).and_raise(ActiveRecord::RecordNotUnique, "index_profiles_on_lower_username")

      form = UpdateProfileForm.new(@user, profile_attributes: @profile_params)
      form.submit

      expect(@user.profile.errors.full_messages).to include("Username has already been taken")
    end
  end
end
