class BooksController < ApplicationController
  before_action :authenticate_user!

  def new
    @book = Book.new
  end
   
  def index
    @books  = Book.all
  end
  
  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books    
  end


  def create
    @book = Book.new
    if @book.save
      redirect_to @book, notice:
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
