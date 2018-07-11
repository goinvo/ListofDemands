require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  describe "#create" do
    it "rescues from non-unique username if validation doesn't catch it" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      expect_any_instance_of(User).to receive(:save).and_raise(ActiveRecord::RecordNotUnique, "index_profiles_on_lower_username")
      expect_any_instance_of(User).to receive(:profile).twice.and_return(Profile.new()) # received twice because of expectation below
      post :create

      expect(assigns(:resource).profile.errors.full_messages).to include("Username has already been taken")
    end
  end
end
