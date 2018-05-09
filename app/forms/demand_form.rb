class DemandForm

  attr_reader :demand, :current_user

  def initialize(current_user, attr = {})
    @current_user = current_user

    if attr[:id]
      @demand = @current_user.demands.find(attr[:id])
      @params = attr.except(:id)
    else
      @demand = @current_user.demands.build
      @params = attr
    end
  end

  def save
    @demand.assign_attributes(@params)
    @demand.area = @params[:is_statewide] == "1" ? @current_user.municipality.state : @current_user.municipality
    @demand.topic = @params[:topic].blank? ? nil : @params[:topic]
    @demand.save
  end

  def has_solution?
    @demand.solution.present?
  end
end
