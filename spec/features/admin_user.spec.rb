# このrequireで、Capybaraなどの、Feature Specに必要な機能を使用可能な状態にしています
require 'rails_helper'

# このRSpec.featureの右側に、「タスク管理機能」のように、テスト項目の名称を書きます（do ~ endでグループ化されています）
RSpec.feature "Admin管理機能", type: :feature do
  background do
    user = FactoryBot.create(:user, admin: "true")
    user_f = FactoryBot.create(:user, name: "taco", email: "taco@123.com")
    FactoryBot.create(:task, user_id: user_f.id)

    visit new_session_path
    fill_in "Email", with: "sample@123.com"
    fill_in "Password", with: "sample123"
  
    click_button "Login" 
  end

  scenario "管理者はユーザー一覧を閲覧できる" do
    
    click_on "Admin Page"
    expect(page).to have_selector 'h1', text: 'USERS INDEX'
  end

  scenario "管理者は他ユーザーのタスクとタスク数を閲覧できる" do

    click_on "Admin Page"
    all('.media')[0].click_on 'Detail'
    save_and_open_page
    expect(page).to have_selector 'li', text: 'Factoryで作ったデフォルトのタイトル1'
    expect(page).to have_selector 'span', text: '1ケ'
  end

  scenario "管理者は他ユーザーを削除できる" do
    expect{
      click_on "Admin Page"
      all('.media')[0].click_on 'Detail'
      click_on "Delete"
    }.to change(User, :count).by(-1)
  end
  

  scenario "非管理者はユーザー一覧ページを見ることができない" do
    click_on "Logout"
    click_on "Sign up"
    fill_in "Name", with: "ex2"
    fill_in "Email", with: "ex2@example.com"
    fill_in "Password", with: "ex2123"
    fill_in "Confirmation", with: "ex2123"

    click_button "Sign up"
    visit admin_users_path
    expect(page).to have_selector 'h1', text: 'Log In'
  end

end
