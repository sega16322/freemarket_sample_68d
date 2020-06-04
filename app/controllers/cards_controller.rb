class CardsController < ApplicationController
  require "payjp"
  before_action :set_item_search_query
  before_action :set_category_brand
  before_action :set_card
  before_action :set_payjp_api, except: [:new]
  before_action :set_item, only: [:buy, :check]
  
  def index
    check_card
  end

  def new
    redirect_to cards_path if @card.present?
  end

  def create
    render :new if params[:payjpToken].blank?
    customer = Payjp::Customer.create(card: params[:payjpToken])
    @card    = Card.new(user_id: current_user.id, payjp_id: customer.id)
    @card.save! ? (redirect_to cards_path) : (render :new)
  end

  def destroy    
    customer = Payjp::Customer.retrieve(@card.payjp_id)
    customer.delete 
    redirect_to cards_path if @card.destroy
  end

  def buy
    if @item.buyer_id.present?
      redirect_to item_path(@item)
    elsif @item.trading_status_id != 1
      redirect_to root_path
    elsif @card.blank?
      render :new
    else
      Payjp::Charge.create(
        amount: @item.price,
        customer: @card.payjp_id,
        currency: 'jpy'
      )
      @item.update(buyer_id: current_user.id) ? (redirect_to item_trading_path(@item, current_user)) : (redirect_to root_path)
    end
  end

  def check
    check_card
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def set_card
    @card = current_user.card
  end

  def set_payjp_api
    Payjp.api_key =  Rails.application.credentials.payjp[:payjp_private_key]
  end

  def check_card
    if @card.present?
      customer    = Payjp::Customer.retrieve(@card.payjp_id)
      @card_info  = customer.cards.retrieve(customer.default_card)
      @card_brand = @card_info.brand
      @exp_month  = @card_info.exp_month.to_s
      @exp_year   = @card_info.exp_year.to_s.slice(2,3)
    else
      render :new
    end
  end

end
