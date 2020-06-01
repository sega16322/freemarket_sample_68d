class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category_brand

  def index
    @user = current_user
    #current_userの投稿に紐づいた通知一覧
      @notifications = @user.passive_notifications
    #@notificationの中でまだ確認していない(indexに一度も遷移していない)通知のみ
      @notifications.where(checked: false).each do |notification|
        notification.update_attributes(checked: true)
      end
    render template: 'users/show'
  end

  def destroy_all
    #通知を全削除
      @notifications = current_user.passive_notifications.destroy_all
      redirect_to users_notifications_path
  end

  private
  
  def set_category_brand
    @parents = Category.where(ancestry: nil)
    @brands = ["シャネル","ナイキ", "ルイヴィトン", "シュプリーム","アディダス"]
  end
end
