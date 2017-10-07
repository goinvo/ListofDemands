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

puts "creating random Demands"
Demand.delete_all
arlington = Area.find_by(name: "Arlington, Massachusetts")
bedford = Area.find_by(name: "Bedford, Massachusetts")
boxford = Area.find_by(name: "Boxford, Massachusetts")

{
  arlington => [juhan, sharon, eric, bernie],
  bedford => [harry, hillary],
  boxford => [rob, trumpy]
}.each do |city, users|
  15.times do
    user = users.sample
    user.demands.create(
      area: user.zip_code.area,
      name: Faker::Lorem.words(2..5).join(' '),
      why: Faker::Lorem.sentence,
      how: Faker::Lorem.paragraphs(2).join("\n")
    )
  end
end