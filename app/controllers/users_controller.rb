class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      user.apikey = SecureRandom.hex
    
      UserActivatorMailer.welcome_email(user).deliver_now
      flash[:success] = "Logged in as #{user.name}"

      redirect_to '/dashboard'
    else
      redirect_to new_user_path
    end
  end

  def show
  end

  def update
    user = User.find(params[:id])
    user.active!
    session[:user_id] = user.id
    if user.save
      flash[:active] = "Thank you! Your account is now activated."
    else
      flash[:error] = "Oops, something went wrong"
    end
    redirect_to dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
