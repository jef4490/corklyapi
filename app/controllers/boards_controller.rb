class BoardsController < ApplicationController

  def index
  end

  def add_owner
    byebug
  end

  def update
    board = Board.find(params[:board][:id])
    Element.where(["board_id = ?", board.id]).delete_all
    board.update(board_params)
    render json: board
  end

  def create
    account = Account.find(Auth.decode(request.headers['token'])["account_id"])
    if account
      if board_params[:id] == nil
        board = Board.new(board_params)
        if board.save
          account.boards << board
          render json: board
        else
          render json: {errors: board.errors}, status: 401
        end
      else
        Board.update_board(board_params)
      end
    else
      render json: {error: "Couldn't find user"}, status: 401
    end
  end

  def show
    account = Account.find(Auth.decode(request.headers['token'])["account_id"])
    if account
      board = Board.find(params[:id])
      if board
        render json: board
      else
        render json: {error: "No board found"}, status: 401
      end
    else
      render json: {error: "Couldn't find user"}, status: 401
    end
  end

  private

  def board_params
    params.require(:board).permit(:title, :id,
      elements_attributes: [:x, :y, :content, :EID])
  end
end
