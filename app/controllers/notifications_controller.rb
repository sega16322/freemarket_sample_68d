class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category_brand
  before_action :set_item
  before_action :set_item_search_query

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


#   private

#   def set_category_brand
#     @parents = Category.where(ancestry: nil)
#     @brands = ["シャネル","ナイキ", "ルイヴィトン", "シュプリーム","アディダス"]
#   end

#   def set_item
#     @item = Item.find_by_id(params[:id])
#   end

#   def item_params
#     params.require(:item).permit(
#       :name, 
#       :explanation,
#       :category_id,
#       :status_id,
#       :delivery_charge_flag,
#       :delivery_method_id,
#       :prefecture_id,
#       :delivery_date_id,
#       :price, 
#       :trading_status_id,
#       images_attributes: [
#         :id,
#         :image,
#         :_destroy
#       ]
#     ).merge(saler_id: current_user.id)
#   end
# end

  def set_notice
    @user = current_user
    @notifications = @user.passive_notifications
  end