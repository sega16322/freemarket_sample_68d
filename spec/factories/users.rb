FactoryBot.define do
  factory :user do
    email                 { Faker::Internet.email }
    password              { "abc1234" }
    password_confirmation { "abc1234" }
    nickname              { Faker::Name.name }
    last_name             { ForgeryJa(:name).last_name }
    first_name            { ForgeryJa(:name).first_name }
    last_name_kana        { ForgeryJa(:name).last_name(to: ForgeryJa::KANA) }
    first_name_kana       { ForgeryJa(:name).first_name(to: ForgeryJa::KANA) }
    birthday              { Faker::Date.birthday }
  end
end