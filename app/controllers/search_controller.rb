class SearchController < ApplicationController

  before_action :ensure_user_area

  def show
    # TODO: deal with unauthenticated users
    @demands = Demand.where(area: user_area)

    if params[:q].present?
      @demands = @demands.basic_search(solution: params[:q])
    end
  end
end
