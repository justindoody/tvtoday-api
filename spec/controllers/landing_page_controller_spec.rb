require 'rails_helper'

describe LandingPageController do
  context "GET index" do
    it "loads" do
      get :index
      assert_response 200
    end
  end
end