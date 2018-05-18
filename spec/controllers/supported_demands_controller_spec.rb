require 'rails_helper'

RSpec.describe SupportedDemandsController, type: :controller do
  before do
    @experience = BasicLodExperience.new

    @user = @experience.boxford_user_new
    @user.confirm
    sign_in @user
  end

  describe "#create" do
    before do
      @demand_to_support = @experience.demands[:boxford_user_boxford_1]
    end

    it "creates a user_demand for a municipal-level demand" do
      expect(@user.user_demands).to be_empty
      post :create, params: { id: @demand_to_support.id }

      expect(@user.user_demands.length).to be(1)
      expect(@user.user_demands.first.demand_id).to eq(@demand_to_support.id)
    end

    it "creates a user_demand for a state-level demand" do
      @demand_to_support = @experience.demands[:boxford_user_mass]
      expect(@user.user_demands).to be_empty
      post :create, params: { id: @demand_to_support.id }

      expect(@user.user_demands.length).to be(1)
      expect(@user.user_demands.first.demand_id).to eq(@demand_to_support.id)
    end

    it "redirects to correct url when given 'redirect' param" do
      url = 'foo.bar/baz'
      post :create, params: { id: @demand_to_support.id, redirect: url }

      expect(response).to redirect_to(url)
    end

    it "redirects to the newly supported demand when no 'redirect' param is given" do
      post :create, params: { id: @demand_to_support.id }

      expect(response).to redirect_to(@demand_to_support)
    end
  end

  describe "#destroy" do
    before do
      @demand_to_remove = @experience.demands[:boxford_user_boxford_1]
      @user.user_demands.create(demand: @demand_to_remove)
    end

    it "deletes a user_demand for a municipal-level demand" do
      expect(@user.user_demands.length).to be(1)
      delete :destroy, params: { id: @demand_to_remove.id }
      @user.user_demands.reload

      expect(@user.user_demands).to be_empty
    end

    it "deletes a user_demand for a state-level demand" do
      @demand_to_remove = @experience.demands[:boxford_user_mass]
      @user.user_demands.create(demand: @demand_to_remove)
      expect(@user.user_demands.length).to be(2)
      delete :destroy, params: { id: @demand_to_remove.id }
      @user.user_demands.reload

      expect(@user.user_demands.length).to be(1)
    end

    it "doesn't delete a demand if the requested demand to delete is non-existent" do
      @demand_to_remove = @experience.demands[:boxford_user_mass]
      expect(@user.user_demands.length).to be(1)
      delete :destroy, params: { id: @demand_to_remove.id }
      @user.user_demands.reload

      expect(@user.user_demands.length).to be(1)
    end

    it "redirects to correct url when given 'redirect' param" do
      url = 'foo.bar/baz'
      delete :destroy, params: { id: @demand_to_remove.id, redirect: url }

      expect(response).to redirect_to(url)
    end

    it "redirects to the newly supported demand when no 'redirect' param is given" do
      delete :destroy, params: { id: @demand_to_remove.id }

      expect(response).to redirect_to(@demand_to_remove)
    end
  end
end
