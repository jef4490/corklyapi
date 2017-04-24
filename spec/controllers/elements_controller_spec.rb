require "rails_helper"

RSpec.describe ElementsController, :type => :controller do
  describe "GET show" do
    before :each do
      @phones_numbers = Element.create!(content: "important information here: 435-887-0198", EID: 7)
    end

    it "has a 200 status code for an element that exists" do
      get :show, params: {id: @phones_numbers.id}
      expect(response.status).to eq(200)
      expect(response.body).to include(@phones_numbers.content)
    end

    # it "has a 404 status code for an element that does not exist" do
    #   get :show, params: {id: 89}
    #   expect(response.status).to eq(200)
    # end

  end
end
