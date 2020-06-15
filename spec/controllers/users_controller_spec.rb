require "rails_helper"

RSpec.describe UsersController do
  before(:each) do
    @experience = BasicLodExperience.new
  end

  describe "#show" do
    it "uses root path" do
      @user_to_visit = @experience.arlington_user
      @user_to_visit.profile.username = nil
      @user_to_visit.save

      expect(get: "/#{@user_to_visit.to_param}").to route_to(
        controller: "users",
        action: "show",
        slug: @user_to_visit.uuid
      )
    end

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

    it "responds to json format" do
      @user_to_visit = @experience.arlington_user
      @user_to_visit.save

      get :show,  params: { slug: @user_to_visit.to_param }, format: :json

      expect(response.header['Content-Type']).to include('application/json')
      expect(JSON(response.body).length).to eq(@user_to_visit.supported_demands.length)
    end

    it "adds demand description to json response" do
      @user_to_visit = @experience.arlington_user
      @user_to_visit.save

      get :show,  params: { slug: @user_to_visit.to_param }, format: :json

      expect(JSON(response.body)[0]["demand_description"]).to eq(@user_to_visit.supported_demands.first.demand_description)
    end

    it "returns 404 when attempting to visit private users" do
      @user_to_visit = @experience.private_user

      expect{get :show, params: { slug: @user_to_visit.to_param }}.to raise_error(ActionController::RoutingError)
      expect(assigns(:user)).to eq(@user_to_visit)
    end
  end
end
