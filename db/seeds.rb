User.create!(name: 'Example User',
             email: 'user@example.com',
             password: 'password',
             password_confirmation: 'password',
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

50.times do |n|
  FactoryGirl.create(:user, email: "user-#{n}@example.com")
end

# Microposts
users = User.all
300.times do
  FactoryGirl.create(:micropost, content: Faker::Lorem.sentence(2), user: users.sample)
end

# Relationships
400.times do
  user = users.sample
  other_user = users.sample
  user.follow(other_user) if other_user.email != user.email && !user.following?(other_user)
end
