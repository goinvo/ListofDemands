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

  def current_user_areas
    if !user_signed_in?
      area = Area.find(session[:area_id])
      [area, area.state, area.country]
    else
      current_user.applicable_areas
    end
  end

  def authenticate_user!
    flash[:custom_unauthenticated] = "You need to sign in or sign up before continuing."
    super
  end
end

def should_have_active_nav_class(path, scope = nil)
  if current_page?(root_url) && scope == ''
    'is-active'
  elsif scope && current_page?(path)
    'is-active' if params[:scope] == scope || (scope == '' && !params[:scope])
  else
    'is-active' if current_page?(path.split('?')[0])
  end
end

private

def area_name_by_params_area(area)
  if params[:scope] == 'county'
    area.county.name_abbreviated
  elsif params[:scope] == 'state'
    area.state.name
  elsif params[:scope] == 'country'
    area.country.short_name
  else
    area.name_abbreviated
  end
end
