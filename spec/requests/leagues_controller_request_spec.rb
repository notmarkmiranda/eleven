require "rails_helper"

describe LeaguesController, type: :request do
  let(:league) { create(:league) }

  describe "GET#show" do
    subject(:get_show) { get league_path(league) }

    describe "for a public league" do
      before do
        league.public!
      end

      it "should render the league#show page" do
        get_show

        expect(response).to have_http_status(200)
      end
    end

    describe "for a private league" do
      let(:user) { league.memberships.last.user }

      before do
        league.update(public_league: false)
        login_user(user)
      end

      describe "for a member or admin on the league" do
        it "should render" do
          get_show

          expect(response).to have_http_status(200)
        end
      end

      describe "for a non-member or non-admin on the league" do
        before { league.memberships.destroy_all }

        it "should redirect" do
          expect {
            get_show
          }.to raise_error Pundit::NotAuthorizedError
        end
      end
    end
  end

  describe "GET#new" do
    subject(:get_new) { get new_league_path }

    describe "for a logged in user" do
      before do
        login_user
      end

      it "should render the new template" do
        get_new

        expect(response).to have_http_status(200)
      end
    end

    describe "for a visitor" do
      it "should redirect" do
        get_new

        expect(response).to have_http_status(302)
      end
    end
  end

  describe "POST#create" do
    subject(:post_create) { post leagues_path, params: league_attrs }
    describe "for a logged in user" do
      before { login_user }

      describe "with valid attributes" do
        let(:league_attrs) { {league: attributes_for(:league)} }

        it "should redirect to league#show page" do
          post_create

          expect(response).to have_http_status(302)
        end

        it "should change the League count" do
          expect {
            post_create
          }.to change(League, :count).by(1)
            .and change(Membership, :count).by(1)
        end
      end

      describe "with invalid attributes" do
        let(:league_attrs) { {league: attributes_for(:league).except(:name)} }

        it "should render a template" do
          post_create

          expect(response).to have_http_status(200)
        end

        it "should not change the League count" do
          expect {
            post_create
          }.not_to change(League, :count)
        end
      end
    end

    describe "for a visitor" do
      let(:league_attrs) { {league: attributes_for(:league)} }

      it "should redirect" do
        post_create

        expect(response).to have_http_status(302)
      end

      it "should not change League count" do
        expect {
          post_create
        }.not_to change(League, :count)
      end
    end
  end

  describe "DELETE#destroy" do
    subject(:delete_destroy) { delete league_path(league) }

    let(:user) { league.user }
    let(:membership) { league.memberships.find_by(user: user) }

    before { login_user(user) }

    describe "for an admin on the league" do
      before { membership.update(role: 1) }

      it "should remove a league from the database" do
        expect {
          delete_destroy
        }.to change(League, :count).by(-1)
        .and change(Membership, :count).by(-1)
      end

      it "should redirect" do
        delete_destroy

        expect(response).to have_http_status(302)
      end
    end

    describe "for a member on the league" do
      before { membership.update(role: 0) }

      it "should not remove a league from the database" do
        expect {
          delete_destroy
        }.to raise_error Pundit::NotAuthorizedError
      end
    end
  end
end
