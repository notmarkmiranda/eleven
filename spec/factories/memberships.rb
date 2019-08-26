FactoryBot.define do
  factory :membership do
    user
    league
    role { 0 }
  end
end
