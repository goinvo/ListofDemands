module ControllerHelpers
  def sign_in(user = create_arlington_user)
    if user.nil?
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
      allow(controller).to receive(:current_user).and_return(nil)
    else
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end
  end

  def create_arlington_user
    create(:area_definition, :arlington)
    create(:user, profile: build(:profile, :arlington))
  end
end
