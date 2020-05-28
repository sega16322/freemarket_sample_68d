FactoryBot.define do
  factory :notification do
    sender_id { 1 }
    receiver_id { 1 }
    item_id { 1 }
    comment_id { 1 }
    like_id { 1 }
    action { "MyString" }
  end
end
