# このrequireで、Capybaraなどの、Feature Specに必要な機能を使用可能な状態にしています
require 'rails_helper'

# このRSpec.featureの右側に、「タスク管理機能」のように、テスト項目の名称を書きます（do ~ endでグループ化されています）
RSpec.feature "グループ管理機能", type: :feature do
  background do
    
    user = FactoryBot.create(:user)
    FactoryBot.create(:task, title: "Factoryで作ったデフォルトのタイトル2", content: 'Factoryで作ったデフォルトのコンテント2',created_at: Date.today-1,sort_expired: Date.today+3,status: 'Finished',priority: 'High', user_id: user.id)
    FactoryBot.create(:group,user_id: user.id)
    FactoryBot.create(:group,name: 'Young Golf',user_id: user.id)

    visit new_session_path
    fill_in "Email", with: "sample@123.com"
    fill_in "Password", with: "sample123"
  
    click_button "Login"
    # FactoryBot.create(:group, user_id: user.id)
  end

  scenario "グループを作成" do
    visit new_group_path

    fill_in "Group Name", with: 'Moku_Moku'
    click_on "Create New Group"
    expect(page).to have_content "Moku_Moku"
  end

  scenario "グループの作成者は、最初からそのグループに参加する" do
    visit new_group_path

    fill_in "Group Name", with: 'Moku_Moku'
    click_on "Create New Group"
    expect(page).not_to have_content 'Leave..'

    click_on "Detail"
    
    group = page.all(".media-heading")[0]
    expect(group).to have_content 'sample'
  end

  scenario "グループ情報の編集や削除はそのグループの作成者のみができる" do

    click_on "Logout"
    click_on "Sign up"
    fill_in "Name", with: "ex2"
    fill_in "Email", with: "ex2@example.com"
    fill_in "Password", with: "ex2123"
    fill_in "Confirmation", with: "ex2123"
    click_button "Sign up"

    click_on "Groups"
    click_on "Create New Group"
    fill_in "Group Name", with: 'Moku_Moku'
    click_on "Create New Group"
    
    
    click_on "Detail"
    expect(page).not_to have_selector '.col_xs_4', text: 'Edit' 
    expect(page).not_to have_selector '.col_xs_4', text: 'Delete'
  end

  scenario "ユーザーは自由に複数のグループに参加できる" do
    click_on "Logout"
    click_on "Sign up"
    fill_in "Name", with: "ex2"
    fill_in "Email", with: "ex2@example.com"
    fill_in "Password", with: "ex2123"
    fill_in "Confirmation", with: "ex2123"
    click_button "Sign up"

    click_on "Groups"
    first('.media-body').click_link 'Join!'
    first('.media-body').click_link 'Detail'
    
    expect(page).to have_selector 'h1', text: 'MyString Info.' 
  end

  scenario "ユーザーは自由に複数のグループに離脱できる" do
    click_on "Logout"
    click_on "Sign up"
    fill_in "Name", with: "ex2"
    fill_in "Email", with: "ex2@example.com"
    fill_in "Password", with: "ex2123"
    fill_in "Confirmation", with: "ex2123"
    click_button "Sign up"

    click_on "Groups"
    first('.media-body').click_link 'Join!'
    first('.media-body').click_link 'Detail'

    click_on 'Groups'
    first('.media-body').click_link 'Leave..'
    
    
    group1 = first('.media-body')
    expect(page).not_to have_selector 'group1', text: 'Detail' 
  end

  scenario "メンバーページに既読、未読判定を追加" do
    click_on "Go Tasks"
    click_on "新規タスク作成"
    fill_in "タスク名", with: "Today.."
    fill_in "タスク内容", with: "So what.."
    click_on "登録する"

    click_on "Groups"
    click_on "Create New Group"

    fill_in "Group Name", with: 'Moku_Moku'
    click_on "Create New Group"

    click_on "Logout"
    click_on "Sign up"
    fill_in "Name", with: "ex2"
    fill_in "Email", with: "ex2@example.com"
    fill_in "Password", with: "ex2123"
    fill_in "Confirmation", with: "ex2123"
    click_button "Sign up"
    click_on "Groups"

    
    page.all('.media-body')[2].click_link 'Join!'
    page.all('.media-body')[2].click_link 'Detail'
    save_and_open_page    
    expect(page).to have_selector '.media-left', text: '未読' 
    
    click_on "Groups"
    page.all('.media-body')[2].click_link 'Detail'
    expect(page).not_to have_selector '.media-left', text: '未読' 
  end

end