class BasicLodExperience

  attr_reader :arlington_user, :bedford_user, :boxford_user, :demands

  def initialize
    add_area_stuff
    add_users
    add_demands
    demand_demands
  end

  private

  def add_area_stuff
    @massachusetts = State.create(name: "Massachusetts")
    @essex = County.create(name: "Essex, Massachusetts")
    @middlesex = County.create(name: "Middlesex, Massachusetts")
    @arlington = Municipality.create(name: "Arlington")
    @bedford = Municipality.create(name: "Bedford")
    @boxford = Municipality.create(name: "Boxford")

    @arlington_zip = FactoryBot.create(:zip_code, :arlington)
    @bedford_zip = FactoryBot.create(:zip_code, :bedford)
    @boxford_zip = FactoryBot.create(:zip_code, :boxford)

    FactoryBot.create(:area_definition, zip_code: @arlington_zip, state: @massachusetts, county: @middlesex, municipality: @arlington)
    FactoryBot.create(:area_definition, zip_code: @boxford_zip, state: @massachusetts, county: @essex, municipality: @boxford)
    FactoryBot.create(:area_definition, zip_code: @bedford_zip, state: @massachusetts, county: @middlesex, municipality: @bedford)
  end

  def add_users
    @arlington_user = FactoryBot.create(:user, profile: FactoryBot.build(:profile, zip: @arlington_zip.zip))
    @bedford_user = FactoryBot.create(:user, profile: FactoryBot.build(:profile, zip: @bedford_zip.zip))
    @boxford_user = FactoryBot.create(:user, profile: FactoryBot.build(:profile, zip: @boxford_zip.zip))
  end

  def add_demands
    @demands = {
      arlington_user_mass: FactoryBot.create(:demand, area: @massachusetts, user: @arlington_user),
      arlington_user_arlington: FactoryBot.create(:demand, area: @arlington, user: @arlington_user),
      bedford_user_mass: FactoryBot.create(:demand, area: @massachusetts, user: @bedford_user),
      bedford_user_bedford_1: FactoryBot.create(:demand, area: @bedford, user: @bedford_user),
      bedford_user_bedford_2: FactoryBot.create(:demand, area: @bedford, user: @bedford_user),
      bedford_user_bedford_3: FactoryBot.create(:demand, area: @bedford, user: @bedford_user),
      boxford_user_mass: FactoryBot.create(:demand, area: @massachusetts, user: @boxford_user),
      boxford_user_boxford_1: FactoryBot.create(:demand, area: @boxford, user: @boxford_user),
      boxford_user_boxford_2: FactoryBot.create(:demand, area: @boxford, user: @boxford_user)
    }
  end

  def demand_demands
    @demands[:arlington_user_mass].user_demands.create(user: @bedford_user)
    @demands[:arlington_user_mass].user_demands.create(user: @boxford_user)
    @demands[:bedford_user_bedford_1].user_demands.create(user: @boxford_user)
    @demands[:bedford_user_bedford_3].user_demands.create(user: @boxford_user)
    @demands[:bedford_user_bedford_1].user_demands.create(user: @arlington_user)
    @demands[:bedford_user_mass].user_demands.create(user: @arlington_user)
    @demands[:boxford_user_mass].user_demands.create(user: @arlington_user)
  end
end
