class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    local_demands_url
  end

  private

  def ensure_user_area
    if !user_signed_in? && session[:area_id].blank?
      session[:set_area_redirect] = request.original_url
      redirect_to new_area_url
    end
  end

  def user_area
    @area ||= user_signed_in? ? current_user.area : Area.find_by(id: session[:area_id])
  end
  helper_method :user_area
end
