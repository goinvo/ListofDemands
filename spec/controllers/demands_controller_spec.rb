require 'rails_helper'

RSpec.describe DemandsController do
  describe '#create' do
    before(:each) do
      @demand_description = 'demand description'
      @valid_attributes = { demand_description: @demand_description, solution: 'solution' }
      user = create_arlington_user
      user.confirm
      sign_in user
    end

    it 'saves a valid demand' do
      post :create, params: { demand: @valid_attributes }

      expect(response).to redirect_to(me_url)
      expect(flash[:notice]).to be(nil)
    end

    it 'saves a Problem but not Demand when given blank solution' do
      skip "Temporarily removed this functionality but it may come back in slightly different form."
      no_solution = @valid_attributes.merge({solution: ''})
      problem_count = Problem.count
      demand_count = Demand.count
      post :create, params: { demand: no_solution }

      expect(response).to redirect_to(search_url)
      expect(Demand.count).to eq(demand_count)
      expect(Problem.count).to eq(problem_count + 1)
      expect(Problem.where(name: @demand_description)).to exist
      expect(flash[:info]).to eq("Okay, we've saved that issue but no demand was created because the proposed solution was empty.")
    end

    it 'provides error messages for an invalid Demand' do
      post :create, params: { demand: { demand_description: '', solution: '' } }

      expect(response).to render_template(:new)
      expect(flash[:alert]).to eq("Oops — we couldn't save those changes...")
      expect(assigns(:demand).errors.full_messages).to include("Demand description can't be blank")
      expect(assigns(:demand).errors.full_messages).to include("Solution can't be blank")
    end
  end
end
