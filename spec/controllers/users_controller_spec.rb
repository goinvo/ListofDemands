require "rails_helper"

RSpec.describe UsersController do
  before(:each) do
    @experience = BasicLodExperience.new
  end

  describe "#show" do
    it "finds correct user when user does not have a username" do
      @user_to_visit = @experience.arlington_user
      @user_to_visit.profile.username = nil
      @user_to_visit.save

      get :show,  params: { slug: @user_to_visit.to_param }

      expect(assigns(:user)).to eq(@user_to_visit)
    end

    it "finds correct user when user has a username" do
      @user_to_visit = @experience.arlington_user
      @user_to_visit.profile.username = "derp"
      @user_to_visit.save

      get :show,  params: { slug: @user_to_visit.to_param }

      expect(assigns(:user)).to eq(@user_to_visit)
    end

    it "returns 404 when attempting to visit private users" do
      @user_to_visit = @experience.private_user

      expect{get :show, params: { slug: @user_to_visit.to_param }}.to raise_error(ActionController::RoutingError)
      expect(assigns(:user)).to eq(@user_to_visit)
    end
  end
end
