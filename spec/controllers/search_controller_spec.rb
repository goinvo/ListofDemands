require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  before do
    # default location from GeoIP is Arlington MA
    @user = create_arlington_user
    @area = @user.area
    stub_arlington_geoip
  end

  describe "GET show" do
    it "assigns @demands" do
      build_demand(area: @area, user: @user)

      get :show

      expect(response.status).to eq(200)
      expect(assigns(:demands)).to eq(Demand.all.to_a)
    end
  end

  def build_demand(area:, user:, count: 1)
    1.times do
      create(:demand, area: area, user: user)
    end
  end
end
