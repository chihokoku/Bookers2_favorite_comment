class BooksController < ApplicationController
  # def new
  #   @book = Book.new
  # end

  def create
    @newbook = Book.new(book_params)
    @newbook.user_id = current_user.id
    # @newbook.save
    # flash[:notice] = "You have cteated new book successfully."
    # redirect_to book_path(@newbook.id)

    if @newbook.save
      flash[:notice]="You have creatad book successfully."
      redirect_to book_path(@newbook.id)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def index
    @user = current_user
    @books = Book.all
    @newbook = Book.new
  end

  def edit
    # @book = Book.find(params[:id])
    @book = Book.find(params[:id])
    if @book.user == current_user
        render "edit"
    else
        redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    # @book.update(book_params)
    # flash[:notice] = "You have updated book successfully."
    # redirect_to book_path(@book.id)
    if @book.update(book_params)
      flash[:notice]="Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
