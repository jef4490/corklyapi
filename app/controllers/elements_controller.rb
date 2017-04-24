class ElementsController < ApplicationController
  def show
    element = Element.find(params[:id])
    if element
      render json: element
    else
      render json: {errors: "Unable to locate element"}, status: 404
    end
  end
end
