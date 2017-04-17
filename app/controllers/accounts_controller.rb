class AccountsController < ApplicationController

  def show
    account = Account.find(Auth.decode(request.headers['token'])["account_id"])
    if account
      render json: account
    else
      render json: {error: "Couldn't find user"}, status: 401
    end
  end
end
