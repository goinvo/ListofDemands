
class AreaController < ApplicationController
  include ActionView::Helpers::NumberHelper

  def new
  end

  def edit
    session[:set_area_redirect] = params[:set_area_redirect].presence
  end

  def update
    if params[:zip].present? && zip = ZipCode.find_by(zip: params[:zip])
      session[:area_id] = zip.municipality.id
      redirect_to session.delete(:set_area_redirect) || search_url
    else
      flash[:alert] = "We know of #{number_with_delimiter(ZipCode.count)} ZIP codes. That wasn't one of them :-("
      redirect_to new_area_url
    end
  end
end
