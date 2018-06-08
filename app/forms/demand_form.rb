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

  def assign_demand_attributes(params, area_id = nil)
    @demand.assign_attributes(params)
    @demand.topic = params[:topic].blank? ? nil : params[:topic]
    if area_id
      @demand.area = Area.find(area_id)
    end
  end

  def save
    # First, dup the params and separate out the areas array
    params = @params.dup
    areas = params.delete :area
    areas.shift # Remove the first value (which is always blank from rails hidden input)

    # Ensure all demands are saved in one fell swoop
    ActiveRecord::Base.transaction do
      # Then update the existing demand if applicable
      if @demand.persisted?
        assign_demand_attributes(params, nil)
        return false if !@demand.save
      end

      # Lastly, make new demands for each area in the areas array
      if !areas.blank?
        areas.each do |area_id|
          @demand = @current_user.demands.build
          assign_demand_attributes(params, area_id)
          return false if !@demand.save
        end
      else
        if (areas.blank? && !@demand.persisted?) # Trying to make a new demand with no area assigned
          assign_demand_attributes(params, nil) # Assign the attributes that are valid to be sent back to form
          return false
        end
        true
      end
    end
  rescue ActiveRecord::RecordInvalid => exception
    return false
  end

  def has_solution?
    @demand.solution.present?
  end

  def has_demand_description?
    @demand.demand_description.present? && !@demand.demand_description.blank?
  end

  def incomplete_demand?
    has_demand_description? && !has_solution?
  end
end
