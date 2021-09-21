class UsersController < ApplicationController
  def index
    @users = User.all
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @users_books = Book.where("user_id=?", params[:id])
  end

  def edit
    redirect_to user_path(current_user) if params[:id].to_i != current_user.id
  end

  def update
    if current_user.update(user_params)
      flash[:success] = "You have updated user successfully."
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end
end
