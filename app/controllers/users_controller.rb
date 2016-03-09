class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new params_user
    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @user = current_user
    @favourite_projects = current_user.favourite_projects
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update params_user
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def password
    @user = current_user
  end

  def password_update
    @user = current_user

    if user_signed_in? && @user.authenticate(params[:user][:password])
      params[:password] = params[:new_password]
      # new_password = current_user.authenticate(params[:new_password])
      params_user_new = params.require(:user).permit(:first_name,:last_name,:email)
      @user.update params_user_new
      redirect_to user_path(current_user)
    else
      flash[:alert] = "Wrong Credentials"
      render :password
    end
  end

  private

  def params_user
    params_user = params.require(:user).permit(:first_name,:last_name,:email,:password,:password_confirmation)
  end
end
