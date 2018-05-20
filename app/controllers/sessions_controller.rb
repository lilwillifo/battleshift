class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Logged in as #{user.name}"
      redirect_to '/dashboard'
    else
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to '/'
  end
end
