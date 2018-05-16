require 'rails_helper'

RSpec.describe Users::SessionsController do
  before(:each) do
    @user = create_arlington_user
    @user.confirm
  end

  describe '#create' do
    it 'does not display a login flash message' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      expect(controller.current_user).to eq(nil)
      post :create,  params: { user: { email: @user.email, password: @user.password } }

      expect(controller.current_user).to eq(@user)
      expect(flash[:notice]).to eq(nil)
    end
  end

  describe '#destroy' do
    before(:each) do
      sign_in @user
    end
    it 'does not display a logout flash message' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_out @user

      expect(controller.current_user).to eq(nil)
      expect(flash[:notice]).to eq(nil)
    end
  end
end
