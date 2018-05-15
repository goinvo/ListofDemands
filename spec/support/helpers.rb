module Helpers
  def create_arlington_user
    create(:area_definition, :arlington)
    create(:user, profile: build(:profile, :arlington))
  end
end
