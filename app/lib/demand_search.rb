class DemandSearch

  SCOPE_FALLBACK = {
    municipality: :county,
    county: :state,
    state: :country,
    country: nil
  }

  attr_reader :current_user, :user_municipality, :scope, :query, :topic, :demands,
              :fallback_demands, :fallback_areas

  def initialize(current_user:, user_municipality:, scope:, query:, topic:)
    @current_user = current_user
    @user_municipality = user_municipality
    @scope = scope.blank? ? :municipality : scope.to_sym
    @query = query || ''
    @topic = topic || ''
    @demands = []
    @fallback_demands = []
    @fallback_areas = []
  end

  def find_demands(fallback = false)
    query = SearchDemand.order("demand_count DESC, created_at DESC")
    query = add_query_scope(query)
    # query = query.advanced_search(solution: process_query) if query?
    query = query.where(topic: process_topic) if topic?

    demands = query.to_a

    @fallback_areas << @scope if fallback && demands.present?

    if ((!fallback && demands.length < 5) || fallback) && scope_fallback.present?
      search = DemandSearch.new(
        current_user: current_user,
        user_municipality: @user_municipality,
        scope: scope_fallback,
        query: query,
        topic: topic
      )

      if fallback
        demands += search.find_demands(true)
      else
        @fallback_demands = search.find_demands(true)
      end

      @fallback_areas += search.fallback_areas
    end

    demands
  end

  private

  def topic?
    !topic.blank?
  end

  def process_topic
    topic
  end

  def scope_fallback
    SCOPE_FALLBACK[scope]
  end

  def add_query_scope(query)
    query_scope =
      if current_user.present?
        current_user.municipality
      else
        user_municipality
      end

    case scope
    when :municipality
      query
        .where(municipality_id: query_scope.id)
    when :county
      query
        .where(municipality_id: query_scope.county.municipalities.pluck(:id).select{ |id| id != @user_municipality.id })
    when :state
      query
        .where(state_id: query_scope.state.id)
    else
      query
        .where(country_id: query_scope.country.id)
    end
  end

  def query?
    process_query.blank?
  end

  def process_query
    query.split(' ').join('|')
  end

end
