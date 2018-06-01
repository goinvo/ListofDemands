class DemandSearch

  SCOPE_FALLBACK = {
    municipality: :county,
    county: :state,
    state: nil
  }

  attr_reader :current_user, :user_municipality, :scope, :query, :topic, :demands

  def initialize(current_user:, user_municipality:, scope:, query:, topic:)
    @current_user = current_user
    @user_municipality = user_municipality
    @scope = scope.blank? ? :municipality : scope.to_sym
    @query = query || ''
    @topic = topic || ''
    @demands = []
  end

  def find_demands
    query = SearchDemand.order("demand_count DESC, created_at DESC")
    query = add_query_scope(query)
    # query = query.advanced_search(solution: process_query) if query?
    query = query.where(topic: process_topic) if topic?

    demands = query.to_a

    if demands.empty? && scope_fallback.present?
      return DemandSearch.new(
        current_user: current_user,
        user_municipality: @user_municipality,
        scope: scope_fallback,
        query: query,
        topic: topic
      ).find_demands
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
        .where(municipality_id: query_scope.county.municipalities.pluck(:id))
    else
      # binding.pry
      query
        .where(state_id: query_scope.state.id)
    end
  end

  def query?
    process_query.blank?
  end

  def process_query
    query.split(' ').join('|')
  end

end
