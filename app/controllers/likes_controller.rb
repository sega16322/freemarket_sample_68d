class LikesController < ApplicationController
  before_action :set_item, except: [:index]
  before_action :move_show_item, except: [:index]

  def index
    @parents = Category.where(ancestry: nil)
    @brands = ["シャネル","ナイキ", "ルイヴィトン", "シュプリーム","アディダス"]
    items = []
    likes = Like.where(user_id: params[:user_id])
    if likes.present?
      likes.each { |like| items << Item.find(like.item_id)}
    end
    @items = Kaminari.paginate_array(items).page(params[:page]).per(15)
  end

  def create
    like = Like.create(user_id: current_user.id, item_id: params[:item_id])
    
    #通知の作成
    @item.create_notification_by(current_user)
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
  end

  def destroy
    like = Like.find(params[:id])
    current_user.id == like.user_id ? ( like.destroy) : (redirect_to root_path)
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_show_item
    redirect_to item_path(@item) if current_user.id == @item.saler_id
  end
end
