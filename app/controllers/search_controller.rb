class SearchController < ApplicationController
  def show
    # TODO: deal with unauthenticated users
    @demands = Demand.where(area: current_user.area)

    if params[:q].present?
      @demands = @demands.basic_search(solution: params[:q])
    end
  end
end
