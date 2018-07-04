require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  before do
    @experience = BasicLodExperience.new
  end

  describe "GET show" do
    it "assigns @demands" do
      stub_arlington_geoip
      get :show

      expect(response.status).to eq(200)
      expect(assigns(:demands)[0].demand).to eq(@experience.demands[:arlington_user_arlington])
      expect(assigns(:demands).length).to eq(1)
    end

    it "assigns @fallback_demands" do
      get :show

      expect(response.status).to eq(200)
      expect(assigns(:demands)).to be_empty
      # expect(assigns(:fallback_demands)).to eq(@experience.demands)
    end
  end
end
