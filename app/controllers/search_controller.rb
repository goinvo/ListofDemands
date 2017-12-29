class SearchController < ApplicationController

  before_action :ensure_user_area

  def show
    @demands = user_area.demands.to_a

    if params[:q].present?
      # TODO: replace this with a proper search engine. elasticsearch?
      query = params[:q].split(' ').join('|')

      demands = @demands.advanced_search(solution: query)

      demands_by_problem = user_area
                   .problems
                   .includes(:demands)
                   .advanced_search(name: query).map { |problem| problem.demands.find { |demand| demand.area == user_area }}.compact

      @demands = Set.new(demands)
                   .merge(demands_by_problem).to_a

    end

    @demands.sort! { |first, second|
      # this will NOT scale
      if first.user_demands.count == second.user_demands.count
        first.created_at > second.created_at ? -1 : 1
      else
        first.user_demands.count > second.user_demands.count ? -1 : 1
      end
    }
  end
end
