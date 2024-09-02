class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    @user_lives = @user.artist&.lives&.page(params[:page])&.per(10)
    @notifications = @user.artist&.notifications&.order(created_at: :desc)&.page(params[:page])&.per(10) || Notification.none
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      if @user.is_artist?
        Artist.create(user_id: @user.id)
      else
        Listener.create(user_id: @user.id)
      end
      reset_session
      log_in @user
      flash[:success] = "登録が完了しました！"
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      flash[:success] = "プロフィールが正常に更新されました!"
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "アカウントを消去しました！"
    redirect_to root_url, status: :see_other 
  end

  def following
    @user = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_followers'
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :profile_text, :is_artist, :password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url, status: :see_other) unless current_user?(@user)
    end
end
