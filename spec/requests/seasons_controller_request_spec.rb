require "rails_helper"

describe SeasonsController, type: :request do
  let(:league) { create(:league) }
  let(:user) { league.user }

  before { login_user(user) }

  describe "POST#create" do
    let(:headers) { { "HTTP_REFERER" => "http://localhost:300/leagues/#{league.id}" } }
    subject (:post_create) { post seasons_path, headers: headers }

    it "should create a new league" do
      expect {
        post_create
      }.to change(Season, :count).by(1)
    end
  end
end
