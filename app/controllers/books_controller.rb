class BooksController < ApplicationController
  before_action :authenticate_user!

    
  def index
    @books  = Book.all
    @book = Book.new
  end
  
  def show
    @user = User.find(params[:id])
    @books = @user.books    
  end


  def create
    @book = current_user.books.build(book_params)
    if @book.save
      redirect_to @book, notice: "You have created book successfully"
    else
      @user = current_user
      @books = @user.books
      render "users/show"
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to @book, notice:
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice:
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
  
end
