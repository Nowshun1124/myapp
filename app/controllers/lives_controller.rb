class LivesController < ApplicationController

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

  end

  private

  def live_map_params
    params.require(:live).permit(:scheduled_at, :description, :latitude, :longitude)
  end

end
