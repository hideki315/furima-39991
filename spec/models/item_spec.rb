require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user: @user)
  end

  describe '商品の投稿' do
    context '商品が投稿できる場合' do
      it '全ての必須項目が存在し、ユーザーが存在すれば保存できる' do
        expect(@item).to be_valid
      end
    end

    context '商品が投稿できない場合' do
      it '全ての必須項目が空では保存できない' do
        @item.product_name = nil
        @item.product_detail = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Product name can't be blank"
        expect(@item.errors.full_messages).to include "Product detail can't be blank"
      end

      it 'カテゴリーが選択されていないと保存できない' do
        @item.product_category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Product category can't be blank"
      end

      it '状況が選択されていないと保存できない' do
        @item.product_situation_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Product situation can't be blank"
      end

      it '配送料の負担が選択されていないと保存できない' do
        @item.delivery_charge_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Delivery charge can't be blank"
      end

      it '発送元の地域が選択されていないと保存できない' do
        @item.delivery_area_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Delivery area can't be blank"
      end

      it '発送までの日数が選択されていないと保存できない' do
        @item.delivery_day_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Delivery day can't be blank"
      end

      it '価格が存在しないと保存できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Price can't be blank"
      end

      it '価格が範囲外の場合は保存できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include "Price must be between ¥300 and ¥9,999,999"
      end

      it '価格が半角数値でない場合は保存できない' do
        @item.price = '３０００'
        @item.valid?
        expect(@item.errors.full_messages).to include "Price must be between ¥300 and ¥9,999,999"
    
        # 無効な価格（数値でない）を設定
        @item.price = 'abc'
        @item.valid?
        expect(@item.errors.full_messages).to include "Price must be between ¥300 and ¥9,999,999"
        end
        
      end
      
    end
  end
