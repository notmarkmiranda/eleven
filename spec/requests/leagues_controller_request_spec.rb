require "rails_helper"

describe LeaguesController, type: :request do
  describe "GET#show" do
    let(:league) { create(:league) }

    subject(:get_show) { get league_path(league) }

    describe "for a public league" do
      before do
        league.public!
      end

      it 'should render the league#show page' do
        get_show

        expect(response).to have_http_status(200)
      end
    end

    describe "for a private league" do
      pending "need to write this test when membership model exists"
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
    subject(:post_create) { post leagues_path, params: league_attrs  }
    describe "for a logged in user" do
      before { login_user }

      describe "with valid attributes" do
        let(:league_attrs) { { league: attributes_for(:league) } }

        it 'should redirect to league#show page' do
          post_create

          expect(response).to have_http_status(302)
        end

        it 'should change the League count' do
          expect {
            post_create
          }.to change(League, :count).by(1)
        end
      end

      describe "with invalid attributes" do
        let(:league_attrs) { { league: attributes_for(:league).except(:name) } }

        it 'should render a template' do
          post_create

          expect(response).to have_http_status(200)
        end

        it 'should not change the League count' do
          expect {
            post_create
          }.not_to change(League, :count)
        end
      end
    end

    describe "for a visitor" do
      let(:league_attrs) { { league: attributes_for(:league) } }

      it 'should redirect' do
        post_create

        expect(response).to have_http_status(302)
      end

      it 'should not change League count' do
        expect {
          post_create
        }.not_to change(League, :count)
      end
    end
  end
end
