
class AreaController < ApplicationController

  def new
  end

  def edit
  end

  def update
    if params[:zip].present? && zip = ZipCode.find_by(zip: params[:zip])
      session[:area_id] = zip.area.id
      redirect_to search_url
    else
      flash[:alert] = "We know of #{ZipCode.count} ZIP codes. That wasn't one of them :-("
      redirect_to new_area_url
    end
  end

end