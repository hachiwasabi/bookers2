class BooksController < ApplicationController
  before_action :authenticate_user!

    
  def index
    @book = Book.new
    @books  = Book.all
    @user = current_user
  end
  
  def show
    @book = Book.find(params[:id])
    @user = @book.user    
    @books = @user.books
    @book_new = Book.new
  end


  def create
    @book = current_user.books.build(book_params)
    @user = current_user
    @books = Book.all
    if @book.save
      redirect_to @book, notice: "You have created book successfully"
    else 
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to books_path
    end
    if @book.update(book_params)
      redirect_to @book, notice: "Book was successfully update."
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    respond_to do |format|
      format.html {redirect_to books_path, notice: "Book was successfully deleted."}
    end

  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
  
end
