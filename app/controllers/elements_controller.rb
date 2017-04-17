class ElementsController < ApplicationController
  def show
    render json: {test: "this is a test"}
  end
end
