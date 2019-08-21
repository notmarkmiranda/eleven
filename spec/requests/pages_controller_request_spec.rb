require "rails_helper"

describe PagesController, type: :request do
  describe "GET#index" do
    it "renders the index template" do
      get root_path

      expect(response).to have_http_status(200)
    end
  end
end
