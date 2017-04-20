class RegistrationsController < ApplicationController

  def new

  end

  def create
    account = Account.new(account_params)
    if account.save
      payload = {account_id: account.id}
      token = Auth.issue(payload)
      render json: {jwt: token}
    else
      render json: {errors: account.errors}, status: 401
    end
  end

  private
  def account_params
    params.require(:account).permit(:username, :email, :password)
  end

end
