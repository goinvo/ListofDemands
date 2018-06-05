class UserCell < Cell::ViewModel
  property :profile, :email, :supported_demands

  def show
    render
  end

  def display_name
    profile.name || email.split("@")[0]
  end
end
