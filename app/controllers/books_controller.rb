class BooksController < ApplicationController
  before_action :get_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:success] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @books = Book.all
      render :index
    end
  end

  def show
    @book_for_entry = Book.new
  end

  def edit
    redirect_to books_path if @book.user_id != current_user.id
  end

  def update
    if @book.update(book_params)
      flash[:success] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private
    def get_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :body)
    end
end
