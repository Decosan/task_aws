require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'Taskバリデーションチェック' do
    it "titleが空ならバリデーションが通らない" do
      task = FactoryBot.build(:task, title:'', content: "content")
      expect(task.valid?).to eq(false)
    end

    it "contentが空ならバリデーションが通らない" do
      task2 = FactoryBot.build(:task, title: '仮タイトル', content: '')
      expect(task2.valid?).to eq(false)
    end

    it "titleとcontentに内容が記載されていればバリデーションが通る" do
      user = FactoryBot.create(:user)
      task3 = user.tasks.create(title: '仮タイトル', content: '成功テスト')
      # byebug
      expect(task3.valid?).to eq(true)
    end
  end
end