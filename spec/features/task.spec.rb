# このrequireで、Capybaraなどの、Feature Specに必要な機能を使用可能な状態にしています
require 'rails_helper'

# このRSpec.featureの右側に、「タスク管理機能」のように、テスト項目の名称を書きます（do ~ endでグループ化されています）
RSpec.feature "タスク管理機能", type: :feature do
  background do

    user = FactoryBot.create(:user)
    FactoryBot.create(:label)
    FactoryBot.create(:label, title:"Work")
    FactoryBot.create(:label, title:"Life")

    FactoryBot.create(:task, user_id: user.id)
    FactoryBot.create(:task, title: "Factoryで作ったデフォルトのタイトル2", content: 'Factoryで作ったデフォルトのコンテント2',created_at: Date.today-1,sort_expired: Date.today+3,status: 'Finished',priority: 'High', user_id: user.id)
    FactoryBot.create(:task, title: "Factoryで作ったデフォルトのタイトル3", content: 'Factoryで作ったデフォルトのコンテント3',created_at: Date.today-3,sort_expired: Date.today-1,status: 'Pending',priority: 'Low', user_id: user.id)

    visit new_session_path
    fill_in "Email", with: "sample@123.com"
    fill_in "Password", with: "sample123"
    click_button "Login"
  end

  scenario "タスク一覧のテスト" do
    click_on "Go Tasks"

    # visitした（到着した）expect(page)に（タスク一覧ページに）「testtesttest」「samplesample」という文字列が
    # have_contentされているか？（含まれているか？）ということをexpectする（確認・期待する）テストを書いている
    expect(page).to have_content 'Factoryで作ったデフォルトのコンテント1'
    expect(page).to have_content 'Factoryで作ったデフォルトのコンテント2'
  end

  scenario "タスク作成のテスト" do
    expect {
      visit new_task_path
      # byebug
      fill_in "タスク名", with: "Today.."
      fill_in "タスク内容", with: "So what.."

      click_on '登録'

      # タスク作成成功のフラッシュメッセージが表示されること
      expect(page).to have_content "So what.."
    }.to change(Task, :count).by(1)
  end


  scenario "タスク詳細のテスト" do
    visit tasks_path
    # save_and_open_page
    page.all("li")[0].click

    expect(page).to have_content 'Factoryで作ったデフォルトのコンテント2'
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    # ここにテスト内容を記載する
    visit tasks_path
    # save_and_open_page
    task_0 = page.all(".media-body")[0]
    task_1 = page.all(".media-body")[1]
    task_2 = page.all(".media-body")[2]
    expect(task_0).to have_content "Factoryで作ったデフォルトのコンテント2"
    expect(task_1).to have_content "Factoryで作ったデフォルトのコンテント3"
    expect(task_2).to have_content "Factoryで作ったデフォルトのコンテント1"
  end

  scenario "タスクの終了期限が降順でソートされているか" do
    # ここにテスト内容を記載する
    visit tasks_path
    click_on '終了期限ソート'
    # save_and_open_page

    task_0 = page.all(".media-body")[0]
    task_1 = page.all(".media-body")[1]
    task_2 = page.all(".media-body")[2]
    expect(task_0).to have_content "Factoryで作ったデフォルトのコンテント3"
    expect(task_1).to have_content "Factoryで作ったデフォルトのコンテント2"
    expect(task_2).to have_content "Factoryで作ったデフォルトのコンテント1"
  end


  scenario "Title検索機能が機能しているか" do
    visit tasks_path
    fill_in "task_title", with: "1"
    click_on 'Search'

    expect(page).to have_content 'Factoryで作ったデフォルトのコンテント1'
  end

  scenario "Status検索機能が機能しているか" do
    visit tasks_path
    select 'Pending', from: 'task_status'
    click_on 'Search'

    expect(page).to have_content 'Factoryで作ったデフォルトのコンテント1'
    expect(page).to have_content 'Factoryで作ったデフォルトのコンテント3'
  end

  scenario "TitleとStatusの同時検索機能が機能しているか" do
    visit tasks_path
    fill_in "task_title", with: "3"
    select 'Pending', from: 'task_status'
    click_on 'Search'

    expect(page).to have_content 'Factoryで作ったデフォルトのコンテント3'
  end

  scenario "Priorityボタンで優先順位を高い方からソートする" do
    visit tasks_path
    click_on "優先順位ソート"

    task_0 = page.all(".media-body")[0]
    task_1 = page.all(".media-body")[1]
    task_2 = page.all(".media-body")[2]
    expect(task_0).to have_content "Factoryで作ったデフォルトのコンテント2"
    expect(task_1).to have_content "Factoryで作ったデフォルトのコンテント1"
    expect(task_2).to have_content "Factoryで作ったデフォルトのコンテント3"
  end

  scenario "ログインしていないのにタスクのページに飛ぼうとした場合、ログインページに遷移させる" do
    click_on "Logout"
    click_on "Go Tasks"
    # save_and_open_page
    expect(page).to have_selector 'h1', text: 'Log In'
  end

  scenario "自分が作成したタスクだけを表示する" do
    click_on "Logout"
    click_on "Sign up"
    fill_in "Name", with: "ex2"
    fill_in "Email", with: "ex2@example.com"
    fill_in "Password", with: "ex2123"
    fill_in "Confirmation", with: "ex2123"

    click_button "Sign up"
    expect(page).not_to have_content 'Factoryで作ったデフォルトのコンテント2'
  end

  scenario "ログインしている時は、ユーザー登録画面（new画面）に行かせない" do
    visit new_user_path
    expect(page).to have_selector 'h1', text: 'User Info.'
  end

  scenario "自分（current_user）以外のユーザのマイページ（userのshow画面）に行かせない" do
    user = FactoryBot.create(:user, email: "ex3@example.com")
    click_on "Logout"
    click_on "Sign up"
    fill_in "Name", with: "ex2"
    fill_in "Email", with: "ex2@example.com"
    fill_in "Password", with: "ex2123"
    fill_in "Confirmation", with: "ex2123"
    click_button "Sign up"
    # byebug
    visit user_path(user.id)
    # save_and_open_page
    expect(page).to have_selector 'h1', text: 'Log In'
  end

  scenario "タスクに複数のラベルを紐付けることができる" do
    expect {
      visit new_task_path
      # byebug
      fill_in "タスク名", with: "Today.."
      fill_in "タスク内容", with: "So what.."
      check "task_label_ids_40"
      check "task_label_ids_41"
      click_on '登録'
      # タスク作成成功のフラッシュメッセージが表示されること
      # save_and_open_page
      task_0 = page.all(".media")[0]
      expect(task_0).to have_selector 'p', text: "Category: 1: Hobby 2: Work"
    }.to change(Task, :count).by(1)

  end

  scenario "紐付いたラベルで検索することができる" do
    visit new_task_path
    # byebug
    fill_in "タスク名", with: "Today.."
    fill_in "タスク内容", with: "So what.."
    check "task_label_ids_43"
    check "task_label_ids_44"
    click_on '登録'

    click_on '新規タスク作成'
    # save_and_open_page

    fill_in "タスク名", with: "TestTitle"
    fill_in "タスク内容", with: "TestContent"
    check "task_label_ids_44"
    check "task_label_ids_45"
    click_on '登録'

    select 'Life', from: 'task_label_ids'
    click_on 'Search'
    expect(page).not_to have_content "So what.."
    expect(page).to have_content "TestContent"
  end

  scenario "指定なしで検索すると全件表示となる" do
    visit tasks_path
    fill_in "task_title", with: ""
    select "Select Box", from: 'task_status'
    select "Select Box", from: 'task_label_ids'

    task_0 = page.all(".media-body")[0]
    task_1 = page.all(".media-body")[1]
    task_2 = page.all(".media-body")[2]
    expect(task_0).to have_content "Factoryで作ったデフォルトのコンテント2"
    expect(task_1).to have_content "Factoryで作ったデフォルトのコンテント3"
    expect(task_2).to have_content "Factoryで作ったデフォルトのコンテント1"
  end

  scenario "StatusカラムがFinished以外のもので、直近１周間前のタスク、期限を過ぎたタスクをusers#showに表示" do
    click_on "User Info"
    save_and_open_page

    expect(page).not_to have_content 'Factoryで作ったデフォルトのコンテント1'
    expect(page).not_to have_content 'Factoryで作ったデフォルトのコンテント2'
    expect(page).to have_content 'Factoryで作ったデフォルトのコンテント3'
  end
end
