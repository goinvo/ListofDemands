class UsersController < ApplicationController
  before_action :check_user_privacy, only: [:show]
  before_action :ensure_user_municipality, only: [:show]

  def show
    @user ||= UserView.new(find_user)
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
end
