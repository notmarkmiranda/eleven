FactoryBot.define do
  factory :season do
    league
    active { false }
    completed { false }
  end
end
