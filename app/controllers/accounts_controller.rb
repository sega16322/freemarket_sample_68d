class AccountsController < ApplicationController
  before_action :set_account, except: [:create]
  before_action :set_item_search_query
  before_action :set_category_brand
  def new
    redirect_to edit_account_path(current_user) if @account.present?
    @account = Account.new
  end
  
  def create
    Account.create!(account_params) ? (redirect_to edit_account_path(current_user)) : (render :new)
  end

  def edit
    redirect_to new_account_path unless @account.present?
  end

  def update
    @account.update!(account_params) ? (redirect_to edit_account_path(current_user)) : (redirect_to root_path)
  end

  def destroy
    redirect_to root_path unless current_user.id == @account.user_id
    @account.destroy! ? (redirect_to edit_account_path(current_user)) : (render :edit)
  end

  private

  def set_account
    @account = current_user.account
  end

  def account_params
    params.require(:account).permit(
      :icon_image, 
      :background_image, 
      :introduction
    ).merge(user_id: current_user.id)
  end
end
