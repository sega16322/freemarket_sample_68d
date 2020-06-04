require 'rails_helper'

describe Account do
  describe "#create" do
    let!(:user){create(:user)}
    context "can save" do
      it "user_idが存在すれば項目が全てみたされていても登録できる事" do
        account = build(:account, user_id: user.id)
        expect(account).to be_valid
      end
      it "user_idが存在すれば項目が全て未入力でも登録できる事" do
        account = build(:not_account, user_id: user.id)
        expect(account).to be_valid
      end
    end
    context "can not save" do
      it "user_idが存在しない場合登録できない事" do
        account = build(:account,user_id: nil)
        account.valid?
        expect(account.errors[:user_id]).to include("を入力してください")
      end
    end
  end
end
