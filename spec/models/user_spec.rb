require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'バリデーション' do
    context '新規登録ができない時' do
      it 'ニックネームが空の場合は登録できない' do
        @user.nick_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include "Nick name can't be blank"
      end

      it 'メールアドレスが空の場合は登録できない' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end

      it 'メールアドレスが重複している場合は登録できない' do
        FactoryBot.create(:user, email: 'test@example.com')
        @user.email = 'test@example.com'
        @user.valid?
        expect(@user.errors.full_messages).to include "Email has already been taken"
      end

      it 'メールアドレスのフォーマットが不正な場合は登録できない' do
        @user.email = 'invalid_email_format'
        @user.valid?
        expect(@user.errors.full_messages).to include "Email is invalid"
      end

      it 'パスワードが空の場合は登録できない' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end

      it 'パスワードが6文字未満の場合は登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
      end

      it 'パスワードが半角英数字混合でない場合は登録できない' do
        @user.password = 'password' # このパスワードは半角英数字混合でない
        @user.password_confirmation = 'password'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is invalid" # メッセージを"Password is invalid"に変更
      end
      

      it 'パスワードとパスワード（確認）が一致しない場合は登録できない' do
        @user.password_confirmation = 'mismatch_password'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end

      it 'お名前(全角)が名字と名前の両方が空の場合は登録できない' do
        @user.first_name = nil
        @user.last_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include "First name can't be blank"
        expect(@user.errors.full_messages).to include "Last name can't be blank"
      end

      it 'お名前(全角)が全角（漢字・ひらがな・カタカナ）でない場合は登録できない' do
        @user.first_name = 'Smith'
        @user.last_name = 'John'
        @user.valid?
        expect(@user.errors.full_messages).to include "First name is invalid"
        expect(@user.errors.full_messages).to include "Last name is invalid"
      end

      it 'お名前カナ(全角)が名字と名前の両方が空の場合は登録できない' do
        @user.katakana_first_name = nil
        @user.katakana_last_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include "Katakana first name can't be blank"
        expect(@user.errors.full_messages).to include "Katakana last name can't be blank"
      end

      it 'お名前カナ(全角)が全角（カタカナ）でない場合は登録できない' do
        @user.katakana_first_name = 'Smith'
        @user.katakana_last_name = 'John'
        @user.valid?
        expect(@user.errors.full_messages).to include "Katakana first name is invalid"
        expect(@user.errors.full_messages).to include "Katakana last name is invalid"
      end

      it '生年月日が空の場合は登録できない' do
        @user.birth_day = nil
        @user.valid?
        expect(@user.errors.full_messages).to include "Birth day can't be blank"
      end
    end
  end
end
