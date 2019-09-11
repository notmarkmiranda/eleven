require "rails_helper"

describe GamesController, type: :request do
  let(:game) { create(:game) }
  let(:league) { game.league }
  let(:user) { league.user }
  let(:membership) { league.memberships.last }

  before { login_user(user) }

  describe "GET#show" do
    subject(:get_show) { get game_path(game) }
    before { league.update(public_league: public_league) }

    describe "When the league is public" do
      let(:public_league) { true }

      it "shows the game" do
        get_show

        expect(response).to have_http_status(200)
      end
    end

    describe "When the league is not public" do
      let(:public_league) { false }

      before { logout_user }

      it "redirects" do
        expect {
          get_show
        }.to raise_error Pundit::NotAuthorizedError
      end
    end
  end

  let(:headers) { {"HTTP_REFERER" => "http://localhost:3000/leagues/#{league.id}"} }

  describe "GET#new" do

    subject(:get_new) { get new_game_path, headers: headers }

    before { membership.update(role: role) }

    describe "When the user is an admin" do
      let(:role) { 1 }

      it "renders" do
        get_new

        expect(response).to have_http_status(200)
      end
    end

    describe "When the user is a member" do
      let(:role) { 0 }

      it "raises an error" do
        expect {
          get_new
        }.to raise_error Pundit::NotAuthorizedError
      end
    end
  end

  describe "POST#create" do
    subject(:post_create) { post games_path, headers: headers, params: game_params }

    before { membership.update(role: role) }

    describe "When the user is an admin" do
      let(:role) { 1 }

      describe "With appropriate game_params" do
        let(:game_params) { { game: attributes_for(:game, season: league.current_season) } }

        it "should create a game" do
          expect { post_create }.to change(Game, :count).by(1)
        end

        it "should redirect" do
          post_create

          expect(response).to have_http_status(302)
        end
      end

      describe "With inappropriate game_params" do
        let(:game_params) { { game: attributes_for(:game, season: league.current_season).except(:buy_in) } }

        it "should not create a game" do
          expect { post_create }.not_to change(Game, :count)
        end

        it "should render" do
          post_create

          expect(response).to have_http_status(200)
        end
      end
    end

    describe "When the user is a member" do
      let(:role) { 0 }

      describe "With appropriate game_params" do
        let(:game_params) { { game: attributes_for(:game, season: league.current_season) } }

        it "should raise an error" do
          expect { post_create }.to raise_error(Pundit::NotAuthorizedError)
        end
      end
    end
  end

  describe "GET#edit" do
    subject(:get_edit) { get edit_game_path(game) }

    before { membership.update(role: role) }

    describe "When the user is an admin" do
      let(:role) { 1 }

      it "should render" do
        get_edit

        expect(response).to have_http_status(200)
      end
    end

    describe "When the user is a member" do
      let(:role) { 0 }

      it "should raise an error" do
        expect { get_edit }.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end

  describe "PATCH#update" do
    subject(:patch_update) { patch game_path(game), params: game_update }

    before { membership.update(role: role) }
    let(:game_update) { { game: { buy_in: 101 } } }

    describe "When the user is an admin" do
      let(:role) { 1 }

      describe "With the appropriate params" do

        it "should update the game" do
          expect { patch_update }.to change { game.reload.buy_in }
        end
        it "should redirect" do
          patch_update

          expect(response).to have_http_status(302)
        end
      end

      describe "With the inappropriate params" do
        let(:game_update) { { game: { buy_in: nil } } }

        it "should not update the game" do
          expect { patch_update }.not_to change { game.reload.buy_in }
        end

        it "should render" do
          patch_update

          expect(response).to have_http_status(200)
        end
      end
    end

    describe "When the user is a member" do
      let(:role) { 0 }

      describe "With the appropriate params" do
        it "should raise an error" do
          expect { patch_update }.to raise_error(Pundit::NotAuthorizedError)
        end
      end
    end
  end

  describe "DELETE#destroy" do
    subject(:delete_destroy) { delete game_path(game) }

    before { membership.update(role: role) }

    describe "When the user is an admin" do
      let(:role) { 1 }

      it "should delete the game" do
        expect { delete_destroy }.to change(Game, :count).by(-1)
      end

      it "should redirect" do
        delete_destroy

        expect(response).to have_http_status(302)
      end
    end

    describe "When the user is a member" do
      let(:role) { 0 }

      it "should raise an error" do
        expect { delete_destroy }.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end
end
