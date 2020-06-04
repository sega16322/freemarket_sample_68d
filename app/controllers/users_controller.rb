class UsersController < ApplicationController
  before_action :set_item_search_query
  before_action :set_category_brand
  
  def index
  end

  def show
  end

  def draft
    @items = Item.draft(current_user.id).page(params[:page]).per(15)
  end

  def exhibition
    @items = Item.exhibition(current_user.id).page(params[:page]).per(15)
  end

  def exhibition_trading
    @items = Item.exhibition_trading(current_user.id).page(params[:page]).per(15)
  end

  def exhibition_completed
    @items = Item.exhibition_completed(current_user.id).page(params[:page]).per(15)
  end

  def bought
    @items = Item.bought(current_user.id).page(params[:page]).per(15)
  end

  def bought_completed
    @items = Item.bought_completed(current_user.id).page(params[:page]).per(15)
  end

end
