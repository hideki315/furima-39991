require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'バリデーション' do
    it 'ニックネームが必須であること' do
      @user.nick_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include "Nick name can't be blank"
    end

    it 'メールアドレスが必須であること' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end

    it 'メールアドレスが一意性であること' do
      FactoryBot.create(:user, email: 'test@example.com')
      @user.email = 'test@example.com'
      @user.valid?
      expect(@user.errors.full_messages).to include "Email has already been taken"
    end

    it 'メールアドレスに@を含む必要があること' do
      @user.email = 'invalid_email_format'
      @user.valid?
      expect(@user.errors.full_messages).to include "Email is invalid"
    end

    it 'パスワードが必須であること' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end

    it 'パスワードが6文字以上であること' do
      @user.password = '12345'
      @user.password_confirmation = '12345'
      @user.valid?
      expect(@user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
    end

    it 'パスワードが半角英数字混合であること' do
      @user.password = 'Password123'
      @user.password_confirmation = 'Password123'
      
      @user.valid?
      expect(@user.errors.full_messages).not_to include "Password confirmation doesn't match Password"
    end

    it 'パスワードとパスワード（確認）が一致すること' do
      @user.password_confirmation = 'mismatch_password'
      @user.valid?
      expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end

    it 'お名前(全角)は、名字と名前がそれぞれ必須であること' do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include "First name can't be blank"
      
      @user.last_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include "Last name can't be blank"
    end

    it 'お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      @user.first_name = 'Smith'
      @user.last_name = 'John'
      @user.valid?
      expect(@user.errors.full_messages).to include "First name is invalid"
      expect(@user.errors.full_messages).to include "Last name is invalid"
    end

    it 'お名前カナ(全角)は、名字と名前がそれぞれ必須であること' do
      @user.katakana_first_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include "Katakana first name can't be blank"
      
      @user.katakana_last_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include "Katakana last name can't be blank"
    end

    it 'お名前カナ(全角)は、全角（カタカナ）での入力が必須であること' do
      @user.katakana_first_name = 'Smith'
      @user.katakana_last_name = 'John'
      @user.valid?
      expect(@user.errors.full_messages).to include "Katakana first name is invalid"
      expect(@user.errors.full_messages).to include "Katakana last name is invalid"
    end

    it '生年月日が必須であること' do
      @user.birth_day = nil
      @user.valid?
      expect(@user.errors.full_messages).to include "Birth day can't be blank"
    end
  end
end
