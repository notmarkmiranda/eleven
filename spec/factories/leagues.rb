FactoryBot.define do
  factory :league do
    sequence :name do |n|
      "League #{n}"
    end
    location { "Denver, CO" }
    public_league { false }
    user
  end
end
