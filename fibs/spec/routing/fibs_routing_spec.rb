require "rails_helper"

RSpec.describe FibsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/fibs").to route_to("fibs#index")
    end

    it "routes to #show" do
      expect(:get => "/fibs/1").to route_to("fibs#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/fibs").to route_to("fibs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/fibs/1").to route_to("fibs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/fibs/1").to route_to("fibs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/fibs/1").to route_to("fibs#destroy", :id => "1")
    end
  end
end
