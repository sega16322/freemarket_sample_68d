require 'rails_helper'

describe SalesPrice do
  describe "#create" do
    let!(:user){create(:user)}
    context "can save" do
      it "必須項目が存在していれば登録できる事" do
        sales_price = build(:sales_price, user_id: user.id)
        expect(sales_price).to be_valid
      end
    end
    context "can not save" do
      it "売上金（sales_price）存在していなければ登録できない事" do
        sales_price = build(:not_sales_price, user_id: user.id)
        sales_price.valid?
        expect(sales_price.errors[:price]).to include("を入力してください")
      end
      it "外部キー（user_id）  存在していなければ登録できない事" do
        sales_price = build(:sales_price, user_id: nil)
        sales_price.valid?
        expect(sales_price.errors[:user_id]).to include("を入力してください")
      end
    end
  end
end