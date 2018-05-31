class ProfileController < ApplicationController

  before_action :authenticate_user!

  def show
  end

  def edit
    @profile = current_user.profile
  end

  def update
    form = UpdateProfileForm.new(current_user, update_params)

    if form.submit
      flash[:info] = "Profile updated!"
      redirect_to profile_url
    else
      @profile = form.user.profile
      flash[:alert] = "Oops — we couldn't save those changes..."
      render :edit
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
