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
    query = query_scope
      .demands
      .includes(:user_demands)

    query = query.advanced_search(solution: process_query) unless process_query.blank?

    query = query.where(topic: process_topic) if topic?

    demands = query.to_a

    if demands.empty? && scope_fallback.present?
      DemandSearch.new(
        current_user: current_user,
        user_municipality: @user_municipality,
        scope: scope_fallback,
        query: query,
        topic: topic
      ).find_demands
    else
      demands.sort! { |first, second|
        # this will NOT scale
        if first.user_demands.count == second.user_demands.count
          first.created_at > second.created_at ? -1 : 1
        else
          first.user_demands.count > second.user_demands.count ? -1 : 1
        end
      }
    end
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

  def query_scope
    # binding.pry
    if current_user.present?
      current_user.send(scope)
    elsif scope == :municipality
      user_municipality
    else
      user_municipality.send(scope)
    end
  end

  def process_query
    query.split(' ').join('|')
  end

end
