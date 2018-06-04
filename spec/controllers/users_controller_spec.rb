require "rails_helper"

RSpec.describe UsersController do
  before(:each) do
    @experience = BasicLodExperience.new
  end

  describe "#show" do
    it "finds correct user" do
      @user_to_visit = @experience.arlington_user
      get :show,  params: { uuid: @user_to_visit.uuid }

      expect(assigns(:user)).to eq(@user_to_visit)
    end

    it "returns 404 when attempting to visit private users" do
      @user_to_visit = @experience.private_user

      expect{get :show, params: { uuid: @user_to_visit.uuid }}.to raise_error(ActionController::RoutingError)
      expect(assigns(:user)).to eq(@user_to_visit)
    end
  end
end
