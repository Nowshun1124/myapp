class StaticPagesController < ApplicationController
  def home
    @lives = Live.all
  end

  def message
  end
end
