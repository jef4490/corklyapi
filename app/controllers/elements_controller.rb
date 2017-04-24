class ElementsController < ApplicationController
  def show
    element = Element.find_by(id: params[:id])
    if element
      render json: element
    else
      render json: {errors: "Unable to locate element"}, status: 404
    end
  end
end
