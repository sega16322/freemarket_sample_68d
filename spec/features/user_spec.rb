require 'rails_helper'

feature 'user', type: :feature do
  feature 'ユーザー登録前' do
    scenario '会員情報入力ができるか' do
      visit new_top_path
      click_on "メールアドレスで登録"
      fill_in "user_nickname",with: "メルカリさん"
      fill_in "user_email",with: "email@gmail.com"
      fill_in "user_password",with: "abc1234"
      fill_in "user_password_confirmation",with: "abc1234"
      fill_in "user_last_name", with: "山田"
      fill_in "user_first_name",with: "太郎"
      fill_in "user_last_name_kana", with: "ヤマダ"
      fill_in "user_first_name_kana", with: "タロウ"
      select '2000', from: 'user_birthday_1i'
      select '10', from: 'user_birthday_2i'
      select '10', from: 'user_birthday_3i'
      click_on "次へ進む"
      expect(page).to have_content("お届け先情報入力")
    end
    
    scenario 'ログインできないこと' do
      visit root_path
      click_on "ログイン"
      fill_in "user_email", with: "bbb@gmail.com"
      fill_in "user_password", with: "1111111"
      click_on "ログイン"
      expect(page).to have_content("アカウントをお持ちでない方はこちら")
    end

    scenario '商品出品ボタンを押すとログインページに遷移すること' do
      visit root_path
      click_on "出品する"
      expect(page).to have_content("アカウントをお持ちでない方はこちら")
    end
  end

  feature 'ユーザー登録後' do
    let(:user) {create(:user)}
    background 'ログインできるか' do
      visit root_path
      click_on "ログイン"
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      click_on "ログイン"
    end

    scenario 'ログインできているとヘッダーにマイページが表示されること' do
      expect(page).to have_content "マイページ"
    end

    scenario 'ログアウトができること' do
      visit user_path(user)
      click_on "ログアウト"
      expect(page).to have_content "新規会員登録"
    end

    scenario '商品出品ボタンを押すと出品ページにに遷移するか' do
      click_on "出品する"
      expect(page).to have_content("出品画像")
    end
  end
end