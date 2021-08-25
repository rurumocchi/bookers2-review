class BooksController < ApplicationController

 before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @book = Book.new
    @user = current_user
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice]= "You have creatad book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
    @new_book = Book.new
  end

  def edit
     @book = Book.find(params[:id])
     if @book.user != current_user
      redirect_to book_path(current_user)
     end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] =  "Book was successfully updated."
       redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      flash[:notice]="Book was successfully destroyed."
      redirect_to books_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:title,:body,:profile_image)
  end

  def ensure_correct_user
   @book = Book.find(params[:id])
    unless @book.user == current_user
     redirect_to books_path
    end
  end

end
