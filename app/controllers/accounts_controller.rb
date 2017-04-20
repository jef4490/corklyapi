class AccountsController < ApplicationController

  def find
    account = Account.find_by(email: params[:email])
    if account
      render json: account
    else
      render json: {error: "That account does not exist"}, status: 401
    end
  end

  def show
    account = Account.find(Auth.decode(request.headers['token'])["account_id"])
    if account
      render json: account
    else
      render json: {error: "Couldn't find user"}, status: 401
    end
  end
end
