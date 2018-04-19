require 'faker'
require_relative "../app/util/zip_code_importer"

puts "importing zip codes, areas, and area definitions"
Util::ZipCodeImporter.run

puts "creating users"
rob = User.find_by(email: "rob@rescuedcode.com")
if rob.blank?
  rob = User.new(
      email: "rob@rescuedcode.com",
      password: "password",
      password_confirmation: "password",
      profile_attributes: {
        address1: "45 Batchelder Rd.",
        city: "Boxford",
        state: "MA",
        zip: "01921"
      })
  rob.skip_confirmation!
  rob.save!
end

juhan = User.find_by(email: "juhan@mit.edu")
if juhan.blank?
  juhan = User.new(
    email: "juhan@mit.edu",
    password: "password",
    password_confirmation: "password",
    profile_attributes: {
      address1: "18 Surry Rd.",
      city: "Arlington",
      state: "MA",
      zip: "02476"
    })
  juhan.skip_confirmation!
  juhan.save!
end

sharon = User.find_by(email: "sharon@goinvo.com")
if sharon.blank?
  sharon = User.new(
    email: "sharon@goinvo.com",
    password: "password",
    password_confirmation: "password",
    profile_attributes: {
      address1: "661 Massachusetts Ave.",
      address2: "3rd Floor",
      city: "Arlington",
      state: "MA",
      zip: "02476"
    })
  sharon.skip_confirmation!
  sharon.save!
end

eric = User.find_by(email: "eric@goinvo.com")
if eric.blank?
  eric = User.new(
    email: "eric@goinvo.com",
    password: "password",
    password_confirmation: "password",
    profile_attributes: {
      address1: "661 Massachusetts Ave.",
      address2: "3rd Floor",
      city: "Arlington",
      state: "MA",
      zip: "02476"
    })
  eric.skip_confirmation!
  eric.save!
end

harry = User.find_by(email: "harrysleeper@gmail.com")
if harry.blank?
  harry = User.new(
    email: "harrysleeper@gmail.com",
    password: "password",
    password_confirmation: "password",
    profile_attributes: {
      address1: "202 Burlington Rd.",
      city: "Bedford",
      state: "MA",
      zip: "01730"
    })
  harry.skip_confirmation!
  harry.save!
end

hillary = User.find_by(email: "hillary-derp@mailinator.com")
if hillary.blank?
  hillary = User.new(
    email: "hillary-derp@mailinator.com",
    password: "password",
    password_confirmation: "password",
    profile_attributes: {
      address1: "202 Burlington Rd.",
      city: "Bedford",
      state: "MA",
      zip: "01730"
    })
  hillary.skip_confirmation!
  hillary.save!
end

bernie = User.find_by(email: "bernie-derp@mailinator.com")
if bernie.blank?
  bernie = User.new(
    email: "bernie-derp@mailinator.com",
    password: "password",
    password_confirmation: "password",
    profile_attributes: {
      address1: "200 Park Ave.",
      city: "Arlington",
      state: "MA",
      zip: "02476"
    })
  bernie.skip_confirmation!
  bernie.save!
end

trumpy = User.find_by(email: "trumpy-derp@mailinator.com")
if trumpy.blank?
  trumpy = User.new(
    email: "trumpy-derp@mailinator.com",
    password: "password",
    password_confirmation: "password",
    profile_attributes: {
      address1: "46 Pond Ln.",
      city: "Arlington",
      state: "MA",
      zip: "02476"
    })
  trumpy.skip_confirmation!
  trumpy.save!
end
User.all.each do |user|
  user.associate_municipality
  user.save!
end

puts "creating random Demands"
Demand.delete_all
arlington = Area.find_by(name: "Arlington, Middlesex, Massachusetts")
bedford = Area.find_by(name: "Bedford, Middlesex, Massachusetts")
boxford = Area.find_by(name: "Boxford, Essex, Massachusetts")

["Americans do not all have access to Primary Care. [Everyone needs Primary Care. Everyone!]",
"Too many Americans can't navigate the healthcare system. [It's too damn complicated!]",
"Healthcare price data is not standardized.",
"Prescription drugs prices are too high.",
"Virtual Primary Care is only on 0.3% of smartphones in 2017.",
"Too few Massachusetts residents can walk to their community health center.",
"There too few Health Centers and too many Health Clinics in Massachusetts.",
"Medical Schools are not collaboratively standardizing the health data, health metrics, and health system algorithms used to care for human beings.",
"Patients don’t own, manage, and fully control their personal health record.",
"Too many Americans die from Opioid Use Disorder.",
"Mental health is not integrated into everyday healthcare.",
"Too many Americans eat shit (ie, are not eating real food).",
"Too many..."].each do |problem_name|
  Problem.create!(name: problem_name)
end

cities_and_users = {
  arlington => [juhan, sharon, eric, bernie],
  bedford => [harry, hillary],
  boxford => [rob, trumpy]
}
cities_and_users.each do |city, users|
  15.times do
    user = users.sample
    user.demands.create(
      area: user.zip_code.municipality,
      problem: Problem.all.sample,
      solution: Faker::Lorem.paragraphs(4).join("\n")
    )
  end
end

# randomly have some users demand some demands
puts "creating random user demands"
users = cities_and_users.values.flatten
UserDemand.delete_all
Demand.all.each do |demand|
  rand(1..3).times do
    filtered_users = users.reject { |u| demand.user == u || u.supported_demands.include?(demand) }
    user = filtered_users.sample
    if user && demand
      UserDemand.create(
        user: user,
        demand: demand
      )
    end
  end
end
