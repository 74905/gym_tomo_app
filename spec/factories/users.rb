Factory.define do
  factory :user do
    name { Faker::Lorem.characters(number: 5) }
    email {Faker::Internet.email }
    introduction { Faker::Lorem.characters(bumber: 20)}
    password{ 'password' }
    password_confirmation {'password'}
  end
end