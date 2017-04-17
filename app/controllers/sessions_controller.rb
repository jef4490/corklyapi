class SessionsController < ApplicationController

  def create
    account = Account.authenticate(account_params[:username], account_params[:password])
    if account
      payload={account_id: account.id}
      token = Auth.issue(payload)
      render json: {jwt: token}
    else
      render json: {error: "Bad username or password"}, status: 401
    end
  end

  private
  def account_params
    params.require(:account).permit(:username, :password)
  end

end
