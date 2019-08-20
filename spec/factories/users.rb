FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "markmiranda#{n}@gmail.com"
    end
    password { "password" }
  end
end
