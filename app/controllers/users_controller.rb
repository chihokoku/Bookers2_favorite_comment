class UsersController < ApplicationController

  def index
    @user = current_user
    @users = User.all
    @newbook = Book.new
  end


  def show
    @user = User.find(params[:id])
    @books = @user.books
    @newbook = Book.new

    # @book = Book.new(book_params)
    # @book.user_id = current_user.id
    # @book.save
    # redirect_to books_path
  end

  def edit
    # @user = User.find(params[:id])
    @user = User.find(params[:id])
    if @user == current_user
        render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    # @user.update(user_params)
    # flash[:notice] = "You have updated user successfully."
    # redirect_to user_path(@user.id)
    if @user.update(user_params)
      flash[:notice]="You have updated user successfully."
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end


end
