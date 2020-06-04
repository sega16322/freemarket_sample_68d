require 'rails_helper'

describe Point do
  describe "#create" do
    let!(:user){create(:user)}
    context "can save" do
      it "必須項目が全て存在すれば登録できる事" do
        point = build(:point, user_id: user.id)
        expect(point).to be_valid
      end
    end
    context "can not save" do
      it "ポイント（point）  存在しなければ登録できない事" do
        point = build(:not_point, user_id: user.id)
        point.valid?
        expect(point.errors[:point]).to include("を入力してください")
      end
      it "外部キー（user_id）存在しなければ登録できない事" do
        point = build(:point, user_id: nil)
        point.valid?
        expect(point.errors[:user_id]).to include("を入力してください")
      end
    end
  end
end
