class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:sessions][:email].downcase)
    if user && user.authenticate(params[:sessions][:email])
      flash[:success] = "ログインしました"
      reset_session
      log_in user
      redirect_to user 
    else
      flash.now[:danger] = "ログインに失敗しました" 
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to root_url, status: :see_other
  end
end
