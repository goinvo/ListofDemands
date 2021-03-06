class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    search_url
  end

  private

  def ensure_user_municipality
    if !user_signed_in? && session[:area_id].blank?
      # attempt to geocode
      location = request.location

      if zip_code = ZipCode.find_by(zip: location.data['zip'])
        session[:area_id] = zip_code.municipality.id
      else
        # :shrug: bad ZIP?
        session[:set_area_redirect] = request.original_url
        redirect_to new_area_url
      end
    end
  end

  def user_municipality
    @area ||= user_signed_in? ? current_user.municipality : Area.find_by(id: session[:area_id])
  end

  helper_method :user_municipality
end
