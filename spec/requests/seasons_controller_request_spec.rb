require "rails_helper"

describe SeasonsController, type: :request do
  let(:league) { create(:league) }
  let(:user) { league.user }
  let(:original_season) { league.seasons_in_order.first }

  before { login_user(user) }

  describe "POST#create" do
    let(:headers) { { "HTTP_REFERER" => "http://localhost:300/leagues/#{league.id}" } }
    subject (:post_create) { post seasons_path, headers: headers }

    it "should create a new league" do
      expect {
        post_create
      }.to change(Season, :count).by(1)
    end

    it "should change an existing season's active attribute" do
      expect {
        post_create; original_season.reload
      }.to change { original_season.active }
    end
  end
end
