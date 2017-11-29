class SupportedDemandsController < ApplicationController
  before_action :authenticate_user!

  def update
    UserDemand.transaction do
      update_params.each_with_index do |user_demand_id, index|
        current_user.user_demands.find(user_demand_id).update_attributes(priority: index + 1)
      end
    end

    if params[:redirect].presence
      redirect_to(me_url)
    else
      head :ok
    end
  end

  private

  def update_params
    params.require(:supported_demands)
  end
end
