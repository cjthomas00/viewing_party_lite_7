require 'faker'

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email  { Faker::Internet.unique.email(name: name) }
    password { Faker::Internet.password }
  end
end