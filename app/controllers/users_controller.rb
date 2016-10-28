class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

  def show
    @user = User.find(params[:id])
  end

  def index
    # paginate method is provided by will_paginate gem
    # links generated by will_paginate in user index page are sending parameter
    # :page
    @users = User.paginate(page: params[:page])
  end

  def new
    #because @user is a User.new, form_for will construct form with post method
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile successfuly updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "user successfuly deleted"
    redirect_to users_path
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Confirms a logged in user
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = 'You must be logged in.'
        redirect_to login_path
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # Confirm an admin user
    def admin_user
      redirect_to root_url unless current_user.admin?
    end
end
