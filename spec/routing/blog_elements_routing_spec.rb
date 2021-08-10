require "rails_helper"

RSpec.describe BlogElementsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/blog_elements").to route_to("blog_elements#index")
    end

    it "routes to #new" do
      expect(get: "/blog_elements/new").to route_to("blog_elements#new")
    end

    it "routes to #show" do
      expect(get: "/blog_elements/1").to route_to("blog_elements#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/blog_elements/1/edit").to route_to("blog_elements#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/blog_elements").to route_to("blog_elements#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/blog_elements/1").to route_to("blog_elements#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/blog_elements/1").to route_to("blog_elements#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/blog_elements/1").to route_to("blog_elements#destroy", id: "1")
    end
  end
end
