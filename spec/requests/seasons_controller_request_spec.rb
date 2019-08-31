require "rails_helper"

describe SeasonsController, type: :request do
  let(:league) { create(:league) }
  let(:user) { league.user }
  let(:original_season) { league.seasons_in_order.first }

  before { login_user(user) }

  describe "GET#show" do
    describe ""
  end

  describe "POST#create" do
    let(:headers) { { "HTTP_REFERER" => "http://localhost:300/leagues/#{league.id}" } }
    subject (:post_create) { post seasons_path, headers: headers }

    describe "for an admin on the league" do
      it "should create a new season" do
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

    describe "for a non-admin on the league" do
      before { user.memberships.last.update(role: 0) }

      it "should raise an error" do
        expect {
          post_create
        }.to raise_error Pundit::NotAuthorizedError
      end
    end
  end

  describe "PATCH#update"

  describe "DELETE#destroy"
end
