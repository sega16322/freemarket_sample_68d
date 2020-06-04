FactoryBot.define do
  factory :account, class: Account do
    icon_image       {"test.jpg"}
    background_image {"test.jpg"}
    introduction     {"よろしく"}
  end

  factory :not_account, class: Account do
  end
end

