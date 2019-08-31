FactoryBot.define do
  factory :game do
    date { "2019-08-31 19:00:00" }
    buy_in { 15 }
    address { "123 Fake Street, Denver, Colorado 80219" }
    season
    completed { false }
  end
end
