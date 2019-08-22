require "rails_helper"

describe DashboardController, type: :request do
  context "GET#show" do
    it "renders the show template" do
      login_user
      get dashboard_path

      expect(response).to have_http_status(200)
    end

    it "redirects a visitor" do
      get dashboard_path

      expect(response).to have_http_status(302)
    end
  end
end
