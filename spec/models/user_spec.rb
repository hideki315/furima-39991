require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it '有効な属性であること' do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end

    it 'ニックネームがなければ無効であること' do
      user = FactoryBot.build(:user, nick_name: nil)
      expect(user).not_to be_valid
    end

    it 'メールアドレスがなければ無効であること' do
      user = FactoryBot.build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it '重複したメールアドレスなら無効であること' do
      FactoryBot.create(:user, email: 'test@example.com')
      user = FactoryBot.build(:user, email: 'test@example.com')
      expect(user).not_to be_valid
    end

    it '適切な形式のメールアドレスでなければ無効であること' do
      user = FactoryBot.build(:user, email: 'invalidemail')
      expect(user).not_to be_valid
    end

    it 'パスワードがなければ無効であること' do
      user = FactoryBot.build(:user, password: nil)
      expect(user).not_to be_valid
    end

    it '6文字未満のパスワードなら無効であること' do
      user = FactoryBot.build(:user, password: '12345', password_confirmation: '12345')
      expect(user).not_to be_valid
    end

    it '文字のみのパスワードなら無効であること' do
      user = FactoryBot.build(:user, password: 'abcdef', password_confirmation: 'abcdef')
      expect(user).not_to be_valid
    end

    it '数字のみのパスワードなら無効であること' do
      user = FactoryBot.build(:user, password: '123456', password_confirmation: '123456')
      expect(user).not_to be_valid
    end

    it 'パスワード確認と一致しなければ無効であること' do
      user = FactoryBot.build(:user, password: 'password', password_confirmation: 'wrongpassword')
      expect(user).not_to be_valid
    end
  end
end