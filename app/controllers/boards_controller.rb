class BoardsController < ApplicationController

  def index
    account = Account.find(Auth.decode(request.headers['token']))
    if account

    else
      render json: {error: "Couldn't find user"}, status: 401
    end
  end
  
end
