require 'rails_helper'

RSpec.describe DemandsController do
  describe '#create' do
    before(:each) do
      @valid_attributes = { problem_text: 'problem text', solution: 'solution' }
      sign_in
    end

    it 'saves a valid demand' do
      post :create, params: { demand: @valid_attributes }

      expect(response).to redirect_to(me_url)
      expect(flash[:notice]).to be(nil)
    end

    it 'saves a Problem but not Demand when given blank solution' do
      no_solution = @valid_attributes.merge({solution: ''})
      post :create, params: { demand: no_solution }

      expect(response).to redirect_to(search_url)
      expect(flash[:info]).to eq("Okay, we've saved that issue but no demand was created because the proposed solution was empty.")
    end

    it 'provides error messages for invalid Demand' do
      post :create, params: { demand: { problem_text: '', solution: '' } }

      expect(response).to render_template(:new)
      expect(flash[:alert]).to eq("Oops — we couldn't save those changes...")
      expect(assigns(:demand).errors.full_messages).to include("Problem text can't be blank")
    end
  end
end
