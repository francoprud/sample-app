FactoryGirl.define do
  factory :user do
    email                 { Faker::Internet.email }
    name                  { Faker::Name.name }
    password              { 'password' }
    password_confirmation { 'password' }
    activated             { true }
    activated_at          { Time.zone.now }
  end
end
