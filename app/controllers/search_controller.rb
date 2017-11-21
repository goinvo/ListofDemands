class SearchController < ApplicationController

  before_action :ensure_area, except: [:new_area, :update_area]
  before_action :set_area

  def show
    # TODO: deal with unauthenticated users
    @demands = Demand.where(area: @area)

    if params[:q].present?
      @demands = @demands.basic_search(solution: params[:q])
    end
  end

  def new_area
  end

  def update_area
    if params[:zip].present? && zip = ZipCode.find_by(zip: params[:zip])
      session[:area_id] = zip.area.id
      redirect_to search_url
    else
      flash[:alert] = "We couldn't find that ZIP. Please try again?"
      redirect_to new_area_search_url
    end
  end

  protected

  def ensure_area
    if !user_signed_in? && session[:area_id].blank?
      redirect_to new_area_search_url
    end
  end

  def set_area
    @area = user_signed_in? ? current_user.area : Area.find_by(id: session[:area_id])
  end
end
