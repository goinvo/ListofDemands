class UpdateProfileForm
  attr_reader :user

  def initialize(current_user, user_params)
    @user = current_user
    @params = user_params[:profile_attributes]
  end

  def submit
    begin
      original_zip = @user.profile.zip

      @user.profile.assign_attributes(@params)

      @user.associate_municipality if @user.profile.zip_changed?

      @user.save!
    rescue ActiveRecord::RecordNotUnique => e
      if e.message.include?("index_profiles_on_lower_username")
        @user.profile.errors.add(:username, "has already been taken")
      else
        errors.add(:base, e.message)
      end
    end
  end
end
