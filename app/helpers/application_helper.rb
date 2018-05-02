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
      if user_signed_in?
        current_user.municipality.name_abbreviated
      elsif (area = Area.find_by(id: session[:area_id])).present?
        "#{area.name_abbreviated}".html_safe
      else
        "listofdemands.us"
      end
    end
  end

  def is_active_topic(topic)
    topic == params[:topic]
  end
end

def is_active_path(path)
  "is-active" if current_page?(path)
end
