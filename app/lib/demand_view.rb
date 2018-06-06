class DemandView < ViewModel
  def wrapped_user
    UserView.new(user)
  end
end
