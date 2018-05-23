require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  before do
    @experience = BasicLodExperience.new
    stub_arlington_geoip
  end

  describe "GET show" do
    context "searching locally" do
      before do
        stub_arlington_geoip
      end

      it "returns demands for Arlington" do
        get :show

        expect(response.status).to eq(200)
        expect(assigns(:demands)).to eq([@experience.demands[:arlington_user_arlington]])
      end
    end

    context "searching in the county" do
      it "returns demands for Middlesex" do
        get :show, params: { scope: 'county' }

        expect(response.status).to eq(200)
        expect(assigns(:demands)).to match_array(
          County.find_by(name: "Middlesex, Massachusetts").demands
        )
      end
    end

    context "searching in the state" do
      it "returns demands for Massachusetts" do
        get :show, params: { scope: 'state' }

        expect(response.status).to eq(200)
        expect(assigns(:demands)).to eq([@experience.demands[:arlington_user_arlington]])
      end
    end
  end
end
