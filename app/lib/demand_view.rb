class DemandView < ViewModel
  def wrapped_user
    UserView.new(user)
  end

  def checked_areas_for_edit
    related_demands.map{ |demand| demand.area.id }.push(area.id)
  end
end
