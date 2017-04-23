class BoardsController < ApplicationController

  def index
  end

  def destroy
    account = Account.find(Auth.decode(request.headers['token'])["account_id"])
    id = params[:id]
    board = Board.find(params[:id])
    if account && board && (account.boards.include? board)
      account.boards.delete(board)
      account.save
      board.destroy if board.accounts.count==0
      render json: id
    else
      render json: {errors: "Unable to delete board"}, status: 401
    end
  end

  def add_owner
    account = Account.find(Auth.decode(request.headers['token'])["account_id"])
    board = Board.find(params[:id])
    collab = Account.find(params[:account_id])
    if account && board && collab && board.accounts.include?(account)
      board.accounts << collab unless board.accounts.include?(collab)
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
    board = Board.find(params[:id])
    if account && board && (account.boards.include? board)
      Element.where(["board_id = ?", board.id]).delete_all
      board.update(board_params)
      render json: board
    else
      render json: {error: "Unable to update board"}, status: 401
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

  def show_public
    board = Board.find_by(slug: params[:slug])
    if board
      render json: board
    else
      render json: {error: "No board found"}, status: 401
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
      elements_attributes: [:x, :y, :content, :height, :width, :bgcolor, :EID, :zIndex, :is_image, :image_blob])
  end
end
