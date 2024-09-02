class StaticPagesController < ApplicationController
  def home
    today = Date.today
    @lives = Live.where(scheduled_at: today.beginning_of_day..today.end_of_day)
                  .page(params[:page]).per(10)
  end

  def message
    @followed_artist = current_user.following.joins(:artist)
    @notifications = Notification.where(artist: @followed_artist).order(created_at: :desc)
  end
end
