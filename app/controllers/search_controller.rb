require "constants"

class SearchController < ApplicationController

  before_action :ensure_user_municipality

  def show
    @demands = user_municipality.demands.to_a

    if params[:q].present?
      # TODO: replace this with a proper search engine. elasticsearch?
      query = params[:q].split(' ').join('|')

      demands = user_municipality.demands.advanced_search(solution: query)

      demands_by_problem = user_municipality
                   .problems
                   .includes(:demands)
                   .advanced_search(name: query).map { |problem| problem.demands.find { |demand| demand.area == user_municipality }}.compact

      @demands = Set.new(demands)
                   .merge(demands_by_problem).to_a
    elsif params[:scope] == 'county'
      county_municipality_ids = user_municipality.county.municipalities.map { |muni| muni.id }
      @demands = Demand.where(area_id: county_municipality_ids).to_a
    elsif params[:scope] == 'state'
      @demands = user_municipality.state.demands.to_a
    end

    if params[:topic].present? && Constants::DEMAND_TOPICS.include?(params[:topic])
      @demands = @demands.select{ |demand| demand.topic == params[:topic] }
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
