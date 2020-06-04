class AddressesController < ApplicationController
  before_action :set_item_search_query
  before_action :set_category_brand
  before_action :set_address, except: [:show]

  def show
  end

  def edit
  end

  def update
    @address.update!(address_params) ? (redirect_to edit_address_path(@address)) : (render :edit)
  end

  private

  def set_address
    @address = current_user.address
  end

  def address_params
    params.require(:address).permit(
      :last_name, 
      :first_name, 
      :last_name_kana, 
      :first_name_kana, 
      :prefectures, 
      :postal_code, 
      :municipality, 
      :address, 
      :phone_number, 
      :building
    )
  end
end
