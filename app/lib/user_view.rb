class UserView < ViewModel
  def display_name
    profile.name || email.split("@")[0]
  end

  def wrapped_supported_demands
    DemandView.collection(supported_demands)
  end
end
