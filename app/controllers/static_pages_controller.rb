class StaticPagesController < ApplicationController
  def home
    @lives = Live.all.page(params[:page]).per(10)
  end

  def message
  end
end
