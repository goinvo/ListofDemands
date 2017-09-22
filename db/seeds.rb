rob = User.new(email: "rob@rescuedcode.com", password: "password", password_confirmation: "password")
rob.skip_confirmation!
rob.save!

juhan = User.new(email: "juhan@mit.edu", password: "password", password_confirmation: "password")
juhan.skip_confirmation!
juhan.save!

sharon = User.new(email: "sharon@goinvo.com", password: "password", password_confirmation: "password")
sharon.skip_confirmation!
sharon.save!

harry = User.new(email: "harrysleeper@gmail.com", password: "password", password_confirmation: "password")
harry.skip_confirmation!
harry.save!

hillary = User.new(email: "hillary-derp@mailinator.com", password: "password", password_confirmation: "password")
hillary.skip_confirmation!
hillary.save!

bernie = User.new(email: "bernie-derp@mailinator.com", password: "password", password_confirmation: "password")
bernie.skip_confirmation!
bernie.save!

trumpy = User.new(email: "trumpy-derp@mailinator.com", password: "password", password_confirmation: "password")
trumpy.skip_confirmation!
trumpy.save!