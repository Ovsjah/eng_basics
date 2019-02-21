require 'rails_helper'

RSpec.describe "Fibs", type: :request do
  describe "GET /fibs" do
    it "works! (now write some real specs)" do
      get fibs_path
      expect(response).to have_http_status(200)
    end
  end
end
