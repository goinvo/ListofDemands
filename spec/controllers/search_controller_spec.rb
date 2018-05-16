require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  before do
    @experience = BasicLodExperience.new
    stub_arlington_geoip
  end

  describe "GET show" do
    it "assigns @demands" do
      get :show

      expect(response.status).to eq(200)
      expect(assigns(:demands)).to eq([@experience.demands[:arlington_user_arlington]])
    end
  end
end
