class UsersController < ApplicationController
  before_action :check_user_privacy, only: [:show]

  def show
    @user ||= UserView.new(find_user)
  end

  private

  def find_user
    # TODO: Not sure how to make this one query
    user = User.joins(:profile).find_by(profiles: { username: params[:slug] })

    if user.blank?
      user = User.find_by(uuid: params[:slug])
    end

    user
  end

  def check_user_privacy
    @user ||= UserView.new(find_user)

    if @user.private?
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end
