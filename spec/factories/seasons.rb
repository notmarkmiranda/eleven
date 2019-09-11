FactoryBot.define do
  factory :season do
    league
    active { true }
    completed { false }
  end
end
