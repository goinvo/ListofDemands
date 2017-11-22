class SearchController < ApplicationController

  before_action :ensure_user_area

  def show
    @demands = user_area.demands

    if params[:q].present?
      # TODO: replace this with a proper search engine. elasticsearch?
      query = params[:q].split(' ').join('|')

      demands = @demands.advanced_search(solution: query)

      demands_by_problem = user_area
                   .problems
                   .includes(:demands)
                   .advanced_search(name: query).map { |problem| problem.demands.find { |demand| demand.area == user_area }}.compact

      @demands = Set.new(demands)
                   .merge(demands_by_problem)
    end
  end
end
