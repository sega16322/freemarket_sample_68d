class NotificationsController < ApplicationController
  def index
    @notifications = [
    @user = User.find(params[:id])
    @item = @user.find(id: @item.saler_id)
    ]
  end
end
