require 'rails_helper'
require 'constants'

RSpec.describe DemandForm do
  before(:each) do
    @user = create_arlington_user
  end

  describe 'initialize' do
    it 'sets @current_user' do
      form = DemandForm.new(@user, {})
      expect(form.current_user).to eq(@user)
    end
    it 'builds new @demand if no id passed in' do
      form = DemandForm.new(@user, {})
      expect(form.demand).to be_instance_of(Demand)
    end
    it 'sets existing @demand if id passed in' do
      demand = create(:demand, :local, user: @user)
      form = DemandForm.new(@user, { id: demand.id })

      expect(form.demand).to be_instance_of(Demand)
      expect(form.demand.id).to be(demand.id)
    end
  end

  describe 'save' do
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
      form = DemandForm.new(@user, {})
      form.save

      expect(form.has_solution?).to eq(false)
    end
    it 'is true if the demand was created along with a solution' do
      form = DemandForm.new(@user, { solution: 'a solution' })
      form.save

      expect(form.has_solution?).to eq(true)
    end
  end

  describe 'has_demand_description?' do
    it 'is false if the demand does not have demand_description' do
      form = DemandForm.new(@user, {})
      form.save

      expect(form.has_demand_description?).to eq(false)
    end
    it 'is true if the demand does have demand_description' do
      form = DemandForm.new(@user, { demand_description: 'some problem' })
      form.save

      expect(form.has_demand_description?).to eq(true)
    end
  end

  describe 'incomplete_demand?' do
    it 'is false if the demand has required properties' do
      form = DemandForm.new(@user, { demand_description: 'some problem', solution: 'a solution' })
      form.save

      expect(form.incomplete_demand?).to eq(false)
    end
    it 'is true if the demand is incomplete (has demand_description but no solution)' do
      form = DemandForm.new(@user, { demand_description: 'some problem', solution: '' })
      form.save

      expect(form.incomplete_demand?).to eq(true)
    end
  end
end
