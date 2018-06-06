class UpdateProfileForm
  attr_reader :user

  def initialize(current_user, user_params)
    @user = current_user
    @params = user_params[:profile_attributes]
  end

  def submit
    original_zip = @user.profile.zip

    @user.profile.assign_attributes(@params)

    @user.associate_municipality if @user.profile.zip_changed?

    @user.save!
  end
end
