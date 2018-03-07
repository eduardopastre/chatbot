FactoryBot.define do
  factory :user do
    username FFaker::Name.first_name
  end
end