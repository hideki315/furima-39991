require 'rails_helper'

RSpec.describe "Itemsses", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/itemss/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/itemss/new"
      expect(response).to have_http_status(:success)
    end
  end

end
