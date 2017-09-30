if User.find_by(email: "rob@rescuedcode.com").blank?
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

if User.find_by(email: "juhan@mit.edu").blank?
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

if User.find_by(email: "sharon@goinvo.com").blank?
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

if User.find_by(email: "").blank?
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

if User.find_by(email: "hillary-derp@mailinator.com").blank?
  hillary = User.new(
    email: "hillary-derp@mailinator.com",
    password: "password",
    password_confirmation: "password",
    profile_attributes: {
      address1: "26 Surry Rd.",
      city: "Arlington",
      state: "MA",
      zip: "02476"
    })
  hillary.skip_confirmation!
  hillary.save!
end

if User.find_by(email: "bernie-derp@mailinator.com").blank?
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

if User.find_by(email: "trumpy-derp@mailinator.com").blank?
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

# import ZipCodes, Areas, and AreaDefinitions
Util::ZipCodeImporter.run