User.create!(name: 'Example User',
             email: 'user@example.com',
             password: 'password',
             password_confirmation: 'password',
             admin: true)

99.times do |n|
  FactoryGirl.create(:user, email: "user-#{n}@example.com")
end
