require 'rails_helper'
require 'constants'

RSpec.describe DemandForm do
  before(:each) do
    @user = create_arlington_user
    @description = "demandform test description"
    @solution = "demandform test solution"
    @areas = [
      @user.municipality.id,
      @user.municipality.state.id,
      @user.municipality.country.id
    ]
  end

  describe 'initialize' do
    it 'sets @current_user' do
      form = DemandForm.new(@user, area: [""])
      expect(form.current_user).to eq(@user)
    end
    it 'builds new @demand if no id passed in' do
      form = DemandForm.new(@user, area: [""])
      expect(form.demand).to be_instance_of(Demand)
    end
    it 'sets existing @demand if id passed in' do
      demand = create(:demand, :local, user: @user)
      form = DemandForm.new(@user, id: demand.id)

      expect(form.demand).to be_instance_of(Demand)
      expect(form.demand.id).to be(demand.id)
    end
  end

  describe "assign_demand_attributes" do
    it "sets topic if topic is present in params" do
      topic = Constants::DEMAND_TOPICS.sample
      @form = DemandForm.new(@user, topic: topic, area: ["", @areas[0]])
      @form.save

      expect(@form.demand.topic).to eq(topic)
    end

    it "sets topic to nil if topic is not present in params" do
      @form = DemandForm.new(@user, topic: "", area: ["", @areas[0]])
      @form.save

      expect(@form.demand.topic).to eq(nil)
    end

    it "assigns area if area is passed in" do
      @form = DemandForm.new(@user, area: ["", @areas[0]])
      @form.save

      expect(@form.demand.area.id).to eq(@areas[0])
    end

    it "leaves area blank if no area passed in for new demand" do
      @form = DemandForm.new(@user, area: [""])
      @form.save

      expect(@form.demand.valid?).to be(false)
      expect(@form.demand.area.blank?).to eq(true)
    end

    it "leaves area unchanged if no area passed in for persisted demand" do
      demand = create(:demand, :local, user: @user)
      params = { id: demand.id, area: [""] }
      form = DemandForm.new(@user, params)
      form.save
      @user.user_demands.reload

      updated_demand = @user.user_demands.first.demand
      expect(updated_demand.area).to eq(demand.area)
    end
  end

  describe "save" do
    before(:each) do
      @basic_demand_params = {demand_description: @description, solution: @solution, area: ["", @areas[0]]}
    end

    it "fails and returns errors with no areas present" do
      @basic_demand_params[:area] = [""]
      form = DemandForm.new(@user, @basic_demand_params)
      form.save

      expect(form.demand.valid?).to be(false)
      expect(form.demand.errors.full_messages).to include("Area must pertain to at least one area")
    end

    it "fails and returns errors with no demand description present" do
      @basic_demand_params[:demand_description] = ""
      form = DemandForm.new(@user, @basic_demand_params)
      form.save

      expect(form.demand.valid?).to be(false)
      expect(form.demand.errors.full_messages).to include("Demand description can't be blank")
    end

    it "fails and returns errors with no solution present" do
      @basic_demand_params[:solution] = ""
      form = DemandForm.new(@user, @basic_demand_params)
      form.save

      expect(form.demand.valid?).to be(false)
      expect(form.demand.errors.full_messages).to include("Solution can't be blank")
    end

    it "creates a single demand with correct area" do
      form = DemandForm.new(@user, @basic_demand_params)
      form.save
      @user.user_demands.reload

      expect(@user.user_demands.length).to eq(1)
      expect(@user.user_demands.first.area.id).to eq(@areas[0])
    end

    it "creates multiple demands with correct areas" do
      areas = @areas.dup
      @basic_demand_params[:area] = areas.unshift("")
      form = DemandForm.new(@user, @basic_demand_params)
      form.save
      @user.user_demands.reload

      expect(@user.user_demands.length).to eq(3)
      3.times do |i|
        expect(@user.user_demands[i].area.id).to eq(@areas[i])
      end
    end

    it "updates a single existing demand" do
      demand = create(:demand, :local, user: @user)
      @basic_demand_params = @basic_demand_params.merge(id: demand.id, area: [""])
      form = DemandForm.new(@user, @basic_demand_params)
      form.save
      @user.user_demands.reload

      updated_demand = @user.user_demands.first.demand
      expect(updated_demand.demand_description).to eq(@basic_demand_params[:demand_description])
      expect(updated_demand.solution).to eq(@basic_demand_params[:solution])
      expect(updated_demand.area).to eq(demand.area)
    end

    it "updates a demand and creates new demands simultaneously" do
      demand = create(:demand, :local, user: @user)
      areas = [@areas[1], @areas[2]]
      @basic_demand_params = @basic_demand_params.merge(id: demand.id, area: areas.unshift(""))
      form = DemandForm.new(@user, @basic_demand_params)
      form.save
      @user.user_demands.reload


      areas.unshift(demand.area.id)
      areas.each_with_index do |area, i|
        demand = @user.user_demands[i].demand
        expect(demand.demand_description).to eq(@basic_demand_params[:demand_description])
        expect(demand.solution).to eq(@basic_demand_params[:solution])
        expect(demand.area.id).to eq(area)
      end
    end

    it "creates relationships between all created demands" do
      areas = @areas.dup
      @basic_demand_params[:area] = areas.unshift("")
      form = DemandForm.new(@user, @basic_demand_params)
      form.save
      @user.user_demands.reload

      @user.user_demands.each do |user_demand|
        expected_demands = @user.user_demands.where.not(demand: user_demand.demand).map do |other_user_demand|
          other_user_demand.demand
        end
        expect(user_demand.demand.related_demands.length).to eq(2)
        expect(user_demand.demand.related_demands).to eq(expected_demands)
      end
    end
  end

  describe 'has_solution?' do
    it 'is false if the demand was NOT created along with a solution' do
      form = DemandForm.new(@user, area: ["", @areas[0]])
      form.save

      expect(form.has_solution?).to eq(false)
    end
    it 'is true if the demand was created along with a solution' do
      form = DemandForm.new(@user, solution: @solution, area: ["", @areas[0]])
      form.save

      expect(form.has_solution?).to eq(true)
    end
  end

  describe 'has_demand_description?' do
    it 'is false if the demand does not have demand_description' do
      form = DemandForm.new(@user, area: ["", @areas[0]])
      form.save

      expect(form.has_demand_description?).to eq(false)
    end
    it 'is true if the demand does have demand_description' do
      form = DemandForm.new(@user, demand_description: @description, area: ["", @areas[0]])
      form.save

      expect(form.has_demand_description?).to eq(true)
    end
  end

  describe 'incomplete_demand?' do
    it 'is false if the demand has required properties' do
      form = DemandForm.new(@user, demand_description: @description, solution: @solution, area: ["", @areas[0]])
      form.save

      expect(form.incomplete_demand?).to eq(false)
    end
    it 'is true if the demand is incomplete (has demand_description but no solution)' do
      form = DemandForm.new(@user, demand_description: @description, solution: '', area: ["", @areas[0]])
      form.save

      expect(form.incomplete_demand?).to eq(true)
    end
  end
end
