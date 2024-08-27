class LivesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :destroy]
  before_action :check_artist_user, only: [:new, :create, :edit, :destroy]

  def new
    @live = Live.new
  end

  def create
    @live = Live.new(live_map_params)
    @live.artist_id = current_user.artist.id
    if @live.save
      redirect_to root_url
    else
      flash.now[:danger] = "失敗しました。"
      logger.error @live.errors.full_messages.join(", ")  # エラー内容をログに出力
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end


  def destroy
    Live.find(params[:id]).destroy
    flash[:success] = "作成したライブを消去しました"
    if request.referrer.nil?
      redirect_to root_url, status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end
  end

  private

    def live_map_params
      params.require(:live).permit(:scheduled_at, :description, :latitude, :longitude)
    end

    def check_artist_user
      unless current_user.is_artist == true
        flash[:danger].now = "この操作はできません"
        redirect_to root_url, status: :unprocessable_entity
      end
    end
end
