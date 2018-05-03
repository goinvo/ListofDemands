module ApplicationHelper
  def edit_area_or_profile_path
    if user_signed_in?
      edit_profile_path
    else
      edit_area_path(set_area_redirect: request.original_url)
    end
  end

  def current_user_area_name
    if user_signed_in?
      area_name_by_params_area(current_user.municipality)
    elsif (area = Area.find_by(id: session[:area_id])).present?
      "#{area_name_by_params_area(area)}".html_safe
    end
  end

  def user_header
    if content_for(:brand)
      yield(:brand)
    else
      area_name = current_user_area_name
      area_name ? area_name : "listofdemands.us"
    end
  end

  def is_active_topic(topic)
    topic == params[:topic]
  end
end

def is_active_path(path)
  current_page?(path)
end

def should_have_active_nav_class(path, scope = nil)
  if scope && current_page?(path)
    'is-active' if params[:scope] == scope || (scope == '' && !params[:scope])
  else
    'is-active' if is_active_path(path)
  end
end

private

def area_name_by_params_area(area)
  if params[:scope] == 'county'
    area.county.name_abbreviated
  elsif params[:scope] == 'state'
    area.state.name
  else
    area.name_abbreviated
  end
end
