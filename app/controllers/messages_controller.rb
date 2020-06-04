class MessagesController < ApplicationController
  include TradingHelper
  before_action :set_item_search_query
  before_action :set_category_brand
  before_action :set_trading_item
  before_action :send_message_to_user?
  before_action :item_user?
  before_action :set_message, only: :destroy
  before_action :set_all_messages

  def create
    redirect_to root_path unless Message.create!(message_params)
  end

  def destroy
    redirect_to root_path unless @message.from_id == current_user.id
    redirect_to root_path unless @message.destroy
  end


  private

  def send_message_to_user?
    trading_item_users(@item)
    @to_user = @saler_user == current_user ?  @buyer_user : @saler_user
  end

  def set_all_messages
    @messages = @item.messages.including.asc
  end

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(
      :message
    ).merge(from_id: current_user.id, to_id: @to_user.id, room_id: @item.id)
  end
end
