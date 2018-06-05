require "cell/partial"

class DemandCell < Cell::ViewModel
  include ActionView::Helpers::NumberHelper
  include Devise::Controllers::Helpers
  include LocalDemandsHelper

  property :name, :solution, :user, :area, :topic, :user_demands

  def user_display_name
    cell(:user, user).display_name
  end

  def owned_by_current_user?
    model.owned_by?(current_user)
  end

  # Rendering functions

  def show
    render
  end

  def list_item(options)
    @count = options[:count]
    render
  end

  def meta
    render
  end

  def support_demand_form
    render
  end
end
