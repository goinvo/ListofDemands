module ApplicationHelper
  def edit_area_or_profile_path
    if user_signed_in?
      edit_profile_path
    else
      edit_area_path(set_area_redirect: request.original_url)
    end
  end

  def user_header
    if content_for(:brand)
      yield(:brand)
    else
      user_signed_in? ?
        current_user.area.name :
        ""
    end
  end
end
