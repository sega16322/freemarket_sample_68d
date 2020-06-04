class CategoriesController < ApplicationController
  before_action :set_item_search_query
  before_action :set_category_brand
  before_action :find_category, except: [:index]
  skip_before_action :authenticate_user!
  
  def index
    
  end

  def show
    @items = []
    if @category.ancestry.nil?
      grandchildren_id = @category.indirect_ids.sort
      find_category_item(grandchildren_id)
    elsif @category.ancestry.include?("/")
      category_item = Item.including.category(params[:id]).trading_not
      category_present(category_item)
    else
      grandchildren_id = @category.child_ids
      find_category_item(grandchildren_id)
    end
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end
  
  def category_present(category_item)
    @items += category_item if category_item.present?
  end

  def find_category_item(grandchildren_id)
    category_item = []
    category_item = Item.including.category(grandchildren_id[0].. grandchildren_id[-1]).trading_not
    category_present(category_item)
  end
end
