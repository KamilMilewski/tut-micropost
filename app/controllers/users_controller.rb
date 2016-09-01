class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    #because @user is a User.new, form_for will construct form with post method
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the sample app!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end