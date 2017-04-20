class BoardsController < ApplicationController

  def index
  end

  def destroy
    id = params[:id]
    board = Board.find(params[:id])
    board.destroy
    render json: id
  end

  def add_owner
    board = Board.find(params[:id])
    account = Account.find(params[:account_id])
    if account && board
      board.accounts << account unless board.accounts.include?(account)
      render json: board
    else
      render json: {errors: "Unable to add collaborator"}, status: 401
    end
  end

  def publish
    account = Account.find(Auth.decode(request.headers['token'])["account_id"])
    board = Board.find(params[:id])
    if account && board && (account.boards.include? board)
      board.slugify(account) unless !!board.slug
      board.public = true
      board.save
      render json: board
    else
      render json: {errors: "Unable to make public"}, status: 401
    end
  end

  def update
    account = Account.find(Auth.decode(request.headers['token'])["account_id"])
    if account
      board = Board.find(params[:board][:id])
      Element.where(["board_id = ?", board.id]).delete_all
      board.update(board_params)
      render json: board
    else
      render json: {error: "Couldn't find user"}, status: 401
    end
  end

  def create
    account = Account.find(Auth.decode(request.headers['token'])["account_id"])
    if account
      board = Board.new(board_params)
      if board.save
        account.boards << board
        render json: board
      else
        render json: {errors: board.errors}, status: 401
      end
    else
      render json: {error: "Couldn't find user"}, status: 401
    end
  end

  def show
    account = Account.find(Auth.decode(request.headers['token'])["account_id"])
    if account
      board = Board.find(params[:id])
      if board && (board.public || (board.accounts.include? account))
        render json: board
      else
        render json: {error: "No board found or board is private"}, status: 401
      end
    else
      render json: {error: "Couldn't find user"}, status: 401
    end
  end

  private

  def board_params
    params.require(:board).permit(:title, :id, :currentcolor,
      elements_attributes: [:x, :y, :content, :height, :width, :bgcolor, :EID])
  end
end
