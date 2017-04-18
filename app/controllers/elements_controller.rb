class ElementsController < ApplicationController
  def show
    element = Element.find(params[:id])
    render json: element
  end
end
