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
      expect(assigns(:demands).length).to eq(1)
      expect(assigns(:demands)[0].demand).to eq(@experience.demands[:arlington_user_arlington])
    end

    it "assigns @fallback_demands with no default demands present" do
      get(:show, params: {}, session: { area_id: @experience.salisbury.id })

      expect(response.status).to eq(200)
      expect(assigns(:demands)).to be_empty
      expect(assigns(:fallback_demands).length).to eq(Demand.where(area_id: [@experience.boxford.id, @experience.massachusetts.id, @experience.usa.id]).length)
      expect(assigns(:fallback_demands)[0].demand).to eq(Demand.where(area_id: @experience.boxford.id).order("id DESC").first)
    end

    it "assigns @fallback_demands with less than 5 default demands present" do
      get :show

      expect(response.status).to eq(200)
      expect(assigns(:demands).length).to eq(1)
      expect(assigns(:fallback_demands).length).to eq(Demand.where(area_id: [@experience.bedford.id, @experience.massachusetts.id, @experience.usa.id]).length)
      expect(assigns(:fallback_demands)[0].demand).to eq(Demand.where(area_id: @experience.massachusetts.id).order("id DESC").first)
    end

    it "does not assign @fallback_demands with 5 or more default demands present" do
      2.times do
        FactoryBot.create(:demand, area: @experience.bedford, user: @experience.bedford_user)
      end
      get(:show, params: {}, session: { area_id: @experience.bedford.id })

      expect(response.status).to eq(200)
      expect(assigns(:demands).length).to eq(5)
      expect(assigns(:fallback_demands)).to be_empty
    end
  end
end
