require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Userバリデーションチェック' do
    it 'nameが空欄の場合、User作成不可' do
      @user = FactoryBot.build(:user, name:'')
      expect(@user.valid?).to eq(false)
    end

    it 'name,ユニークemail,passwordを入力の場合はUser作成' do
      @user = FactoryBot.create(:user)
      expect(@user.valid?).to eq(true)
    end

    it 'emailが重複している場合、User作成不可' do
      user2 = FactoryBot.create(:user, email: 'Test1@example.com')
      # user3 = FactoryBot.create(:user, email: 'Test1@example.com')
      user3 = User.create(email: 'Test1@example.com')
      # find_by find_by!
      # create!
      # @user = FactoryBot.create(:user)
      # byebugß
      expect(user3.valid?).to eq(false)
      expect(user3.errors[:email]).to include("はすでに存在します")
    end
  end
end
