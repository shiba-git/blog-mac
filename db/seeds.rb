User.create!(name:  "User",
             email: "example@railstutorial.org",
             password:              "password",
             password_confirmation: "password",
                         admin: true,
              activated: true,
              activated_at: Time.zone.now)

9.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end