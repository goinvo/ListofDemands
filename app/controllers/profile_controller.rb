class ProfileController < ApplicationController

  before_action :authenticate_user!

  def show
  end

  def edit
  end

  def update
    form = UpdateProfileForm.new(current_user, update_params)

    if form.submit
      flash[:info] = "Profile updated!"
      redirect_to profile_url
    else
      flash[:alert] = "Oops — we couldn't save those changes..."
      redirect_to edit_profile_url
    end
  end

  private

  def update_params
    params.require(:user).permit(
      profile_attributes: [
        :name,
        :address1,
        :address2,
        :city,
        :state,
        :zip,
        :gender,
        :date_of_birth,
        :policitcal_party
      ]
    )
  end
end
