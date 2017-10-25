module LocalDemandsHelper
  def demanded_by_user?(demand) 
    user_signed_in? && current_user.supported_demands.include?(demand)
  end
end
