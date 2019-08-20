FactoryBot.define do
  factory :league do
    sequence :name do |n|
      "League #{n}"
    end
    location { "Denver, CO" }
    public { false }
    user
  end
end
