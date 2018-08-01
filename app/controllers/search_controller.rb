require "constants"

class SearchController < ApplicationController

  before_action :ensure_user_municipality

  def show
    search = DemandSearch.new(
      current_user: current_user,
      user_municipality: user_municipality,
      scope: params[:scope],
      query: params[:q],
      topic: params[:topic]
    )
    @demands = search.find_demands
    @fallback_demands = search.fallback_demands
    @fallback_areas = search.fallback_areas
  end
end
