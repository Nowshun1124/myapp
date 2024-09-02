class NotificationsController < ApplicationController
  def new
    @notification = Notification.new
  end

  def create
    @notification = Notification.new(notification_params)
    @notification.artist_id = current_user.artist.id
    if @notification.save
      redirect_to root_url
    else
      flash[:danger] = "失敗しました"
      logger.error @live.errors.full_messages.join(", ")  # エラー内容をログに出力
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

    def notification_params
      params.require(:notification).permit(:message)
    end
end
