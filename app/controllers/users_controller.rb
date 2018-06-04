class UsersController < ApplicationController
  before_action :check_user_privacy, only: [:show]

  def show
    @user = @user || find_user
  end

  private

  def find_user
    User.find_by(uuid: params[:uuid])
  end

  def check_user_privacy
    @user = find_user

    if @user.private?
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end
