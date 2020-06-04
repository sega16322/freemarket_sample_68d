require 'rails_helper'

describe Message do
  describe "#create" do
    let!(:user){create(:user)}
    let!(:item){create(:item)}
    context "can save" do
      it "必須項目全てが存在していれば登録できる事" do
        message = build(:message, from_id: user.id, room_id: item.id)
        expect(message).to be_valid
      end
    end
    context "can not save" do
      it "メッセージ（message）存在していない場合登録できない事" do
        message = build(:message, message: "",from_id: user.id, room_id: item.id)
        message.valid?
        expect(message.errors[:message]).to include("を入力してください")
      end
      it "送り主（from_id）    存在していない場合登録できない事" do
        message = build(:message,from_id: nil, room_id: item.id)
        message.valid?
        expect(message.errors[:from_id]).to include("を入力してください")
      end
      it "送り先（to_id）      存在していない場合登録できない事" do
        message = build(:message,from_id: user.id, to_id: nil, room_id: item.id)
        message.valid?
        expect(message.errors[:to_id]).to include("を入力してください")
      end
      it "DMルーム（room_id）  存在していない場合登録できない事" do
        message = build(:message,from_id: user.id, room_id: nil)
        message.valid?
        expect(message.errors[:room_id]).to include("を入力してください")
      end
    end
  end
end