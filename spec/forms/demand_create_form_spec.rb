require 'rails_helper'

RSpec.describe DemandCreateForm do
  describe 'initialize' do
    it 'sets @current_user' do
      user = create_arlington_user
      form = DemandCreateForm.new(user, {})
      expect(form.current_user).to eq(user)
    end
    it 'sets @demand' do
      user = create_arlington_user
      form = DemandCreateForm.new(user, {})
      expect(form.demand).to be_instance_of(Demand)
    end
  end

  describe 'has_solution?' do
    it 'is false if the demand was NOT created along with a solution' do
      user = create_arlington_user
      form = DemandCreateForm.new(user, {})
      form.submit

      expect(form.has_solution?).to eq(false)
    end
    it 'is true if the demand was created along with a solution' do
      user = create_arlington_user
      form = DemandCreateForm.new(user, { solution: 'a solution' })
      form.submit

      expect(form.has_solution?).to eq(true)
    end
  end

  def create_arlington_user
    create(:area_definition, :arlington)
    create(:user, profile: build(:profile, :arlington))
  end
end
