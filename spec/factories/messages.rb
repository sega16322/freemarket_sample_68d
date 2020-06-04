FactoryBot.define do
  factory :message, class: Message do
    message {"message"}
    to_id   {1}
  end 
end
