FactoryBot.define do
  #### Area/Municipality ####
  factory :area do
    name { "#{Faker::Address.city}, #{Faker::Address.state}" }
  end

  factory :municipality, parent: :area, class: "Municipality" do
    type "Municipality"
  end

  factory :state, parent: :area, class: "State" do
    type "State"
  end

  #### Area Definition ####
  factory :area_definition do
    trait :arlington do
      municipality { create(:municipality, name: "Arlington, Massachusetts") }
      state { create(:state, name: "Massachusetts") }
      zip_code { create(:zip_code, :arlington) }
    end

    trait :bedford do
      municipality { create(:municipality, name: "Bedford, Massachusetts") }
      state { create(:state, name: "Massachusetts") }
      zip_code { create(:zip_code, :bedford) }
    end
  end

  #### Profile ####
  factory :profile do
    address1 { "#{Faker::Address.street_address}" }
    city { "#{Faker::Address.city}" }
    state { "#{Faker::Address.state}" }
    trait :arlington do
      zip "02474"
    end

    trait :bedford do
      zip "01730"
    end
  end

  #### User ####
  sequence :user_email do |n|
    "user#{n}@listofdemands.us"
  end

  factory :user do
    email { generate(:user_email) }
    password "password"
    password_confirmation "password"
  end

  #### ZipCode ####
  factory :zip_code do
    trait :arlington do
      zip "02474"
      city "Arlington"
      state "Massachusetts"
      state_abbreviation "MA"
      county "Middlesex"
      latitude "42.4202"
      longitude "-71.1565"
    end

    trait :bedford do
      zip "01730"
      city "Bedford"
      state "Massachusetts"
      state_abbreviation "MA"
      county "Middlesex"
      latitude "42.4843"
      longitude "-71.2768"
    end
  end

  factory :problem do
    name "problem"
  end

  factory :demand do
    trait :local do
      user { create(:user, profile: build(:profile, :arlington)) }
      problem { create(:problem) }
      area { create(:municipality) }
      solution "solution"
    end

    trait :statewide do
      user { create(:user, profile: build(:profile, :arlington)) }
      problem { create(:problem) }
      area { create(:state) }
      solution "solution"
    end
  end
end
