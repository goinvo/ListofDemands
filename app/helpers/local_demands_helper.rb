module LocalDemandsHelper
  def demanded_by_user?(demand)
    return false unless user_signed_in?
    current_user.user_demands.include?(demand)
  end
end
