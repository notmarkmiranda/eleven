require "rails_helper"

describe SeasonsController, type: :request do
  let(:league) { create(:league) }
  let(:user) { league.user }
  let(:original_season) { league.seasons_in_order.first }
  let(:membership) { league.memberships.last }

  before { login_user(user) }

  describe "GET#show" do
    subject(:get_show) { get season_path(original_season) }

    describe "when the league is public" do
      before do
        league.update(public_league: true)
        logout_user
      end

      it "should render the season" do
        get_show

        expect(response).to have_http_status(200)
      end
    end

    describe "when the league is private" do
      let(:membership) { league.memberships.last }

      describe "when the user is a member" do
        before { membership.update(role: 0) }

        it "should render the season" do
          get_show

          expect(response).to have_http_status(200)
        end
      end

      describe "when the user is an admin" do
        before { membership.update(role: 1) }

        it "should render the season" do
          get_show

          expect(response).to have_http_status(200)
        end
      end

      describe "when the user not an admin or member" do
        before { login_user }

        it "should raise an error" do
          expect {
            get_show
          }.to raise_error Pundit::NotAuthorizedError
        end
      end
    end
  end

  describe "POST#create" do
    let(:headers) { {"HTTP_REFERER" => "http://localhost:300/leagues/#{league.id}"} }
    subject(:post_create) { post seasons_path, headers: headers }

    describe "for an admin on the league" do
      it "should create a new season" do
        expect {
          post_create
        }.to change(Season, :count).by(1)
      end

      it "should change an existing season's active attribute" do
        expect {
          post_create
        }.to change { original_season.reload.active }
      end
    end

    describe "for a non-admin on the league" do
      before { membership.update(role: 0) }

      it "should raise an error" do
        expect {
          post_create
        }.to raise_error Pundit::NotAuthorizedError
      end
    end
  end

  describe "PATCH#update" do
    let(:season_params) { {season: {active: true}} }

    subject(:patch_update) { patch season_path(original_season), params: season_params }
    describe "for an admin on the league" do
      before { original_season.update(active: false) }

      it "should update the season" do
        expect {
          patch_update
        }.to change { original_season.reload.active }
      end
    end

    describe "for a non-admin on the league" do
      before { membership.update(role: 0) }

      it "should raise an error" do
        expect {
          patch_update
        }.to raise_error Pundit::NotAuthorizedError
      end
    end
  end

  describe "DELETE#destroy" do
    subject(:delete_destroy) { delete season_path(original_season) }

    describe "when the user is an admin on the league" do
      it "should delete the season" do
        expect {
          delete_destroy
        }.to change(Season, :count).by(-1)
      end
    end

    describe "when the user is a non-admin on the league" do
      before { membership.update(role: 0) }

      it "should raise an error" do
        expect {
          delete_destroy
        }.to raise_error Pundit::NotAuthorizedError
      end
    end
  end
end
