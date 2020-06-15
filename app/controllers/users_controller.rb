class UsersController < ApplicationController
  before_action :check_user_privacy, only: [:show]
  before_action :ensure_user_municipality, only: [:show], unless: :format_json?

  def show
    @user ||= UserView.new(find_user)
    demands_json = []

    if format_json?
      @user.wrapped_supported_demands.each do |demand|
        demand_attrs = demand.attributes
        demand_attrs["demand_description"] = demand.demand_description
        demands_json << demand_attrs
      end
    end

    respond_to do |format|
      format.html
      format.json { render json: demands_json }
    end
  end

  private

  def find_user
    User.joins(:profile).where(profiles: { username: params[:slug] }).or(User.joins(:profile).where(uuid: params[:slug])).first
  end

  def check_user_privacy
    @user ||= UserView.new(find_user)

    if !@user || @user.private?
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def format_json?
    request.format.symbol == :json
  end
end
