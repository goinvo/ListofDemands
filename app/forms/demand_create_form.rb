class DemandCreateForm

  attr_reader :demand, :current_user

  def initialize(current_user, create_params)
    @current_user = current_user
    @create_params = create_params
    @demand = @current_user.demands.build
  end

  def submit
    @demand.assign_attributes(@create_params)
    @demand.area = @demand.is_statewide == "1" ? @current_user.municipality.state : @current_user.municipality
    @demand.topic = @demand.topic.blank? ? nil : @demand.topic
    @demand.save
  end

  def has_solution?
    @demand.solution.present?
  end
end
