require 'rails_helper'
require 'constants'

RSpec.describe DemandForm do
  describe 'initialize' do
    it 'sets @current_user' do
      user = create_arlington_user
      form = DemandForm.new(user, {})
      expect(form.current_user).to eq(user)
    end
    it 'builds new @demand if no id passed in' do
      user = create_arlington_user
      form = DemandForm.new(user, {})
      expect(form.demand).to be_instance_of(Demand)
    end
    it 'sets existing @demand if id passed in' do
      user = create_arlington_user
      demand = create(:demand, :local, user: user)
      form = DemandForm.new(user, { id: demand.id })

      expect(form.demand).to be_instance_of(Demand)
      expect(form.demand.id).to be(demand.id)
    end
  end

  describe 'save' do
    before(:each) do
      @user = create_arlington_user
    end

    it 'sets area as municipality if is_statewide is false' do
      @form = DemandForm.new(@user, {is_statewide: '0'})
      @form.save

      expect(@form.demand.area.type).to eq('Municipality')
    end
    it 'sets area as state if is_statewide is true' do
      @form = DemandForm.new(@user, {is_statewide: '1'})
      @form.save

      expect(@form.demand.area.type).to eq('State')
    end
    it 'sets topic if topic present' do
      topic = Constants::DEMAND_TOPICS.sample
      @form = DemandForm.new(@user, {topic: topic})
      @form.save

      expect(@form.demand.topic).to eq(topic)
    end
    it 'sets topic to nil if topic not present' do
      @form = DemandForm.new(@user, {topic: ''})
      @form.save

      expect(@form.demand.topic).to eq(nil)
    end
  end

  describe 'has_solution?' do
    it 'is false if the demand was NOT created along with a solution' do
      user = create_arlington_user
      form = DemandForm.new(user, {})
      form.save

      expect(form.has_solution?).to eq(false)
    end
    it 'is true if the demand was created along with a solution' do
      user = create_arlington_user
      form = DemandForm.new(user, { solution: 'a solution' })
      form.save

      expect(form.has_solution?).to eq(true)
    end
  end

  describe 'has_problem_text?' do
    it 'is false if the demand does not have problem_text' do
      user = create_arlington_user
      form = DemandForm.new(user, {})
      form.save

      expect(form.has_problem_text?).to eq(false)
    end
    it 'is true if the demand does have problem_text' do
      user = create_arlington_user
      form = DemandForm.new(user, { problem_text: 'some problem' })
      form.save

      expect(form.has_problem_text?).to eq(true)
    end
  end

  def create_arlington_user
    create(:area_definition, :arlington)
    create(:user, profile: build(:profile, :arlington))
  end
end
