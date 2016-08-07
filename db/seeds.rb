User.create!(name:  "User",
             email: "example@railstutorial.org",
             password:              "password",
             password_confirmation: "password",
              admin: true,
              activated: true,
              activated_at: Time.zone.now)

User.create!(name:  "Shiba",
             email: "shiba@example.com",
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



users = User.order(:created_at).take(2)
5.times do
  title = Faker::Lorem.sentence(2)
  description = Faker::Lorem.sentence(5)
  users.each { |user| user.posts.create!(title: title, description: description) }
end