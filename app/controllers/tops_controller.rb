class TopsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_item_search_query
  before_action :set_category_brand,  only: [:index]
  
  def index  
    @items = Item.including.limit(5).desc.trading_not
  end
  
  def new
  end
end
