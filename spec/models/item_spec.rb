require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user: @user)
  end

  describe '商品の投稿' do
    context '商品が投稿できる場合' do
      it '全ての必須項目が存在すれば保存できる' do
        expect(@item).to be_valid
      end
    end

    context '商品が投稿できない場合' do
      it '全ての必須項目が空では保存できない' do
        @item.product_name = nil
        @item.product_detail = nil
        expect(@item).to_not be_valid
      end

      it 'カテゴリーが選択されていないと保存できない' do
        @item.product_category_id = nil
        expect(@item).to_not be_valid
      end

      it '状況が選択されていないと保存できない' do
        @item.product_situation_id = nil
        expect(@item).to_not be_valid
      end

      it '配送料の負担が選択されていないと保存できない' do
        @item.delivery_charge_id = nil
        expect(@item).to_not be_valid
      end

      it '発送元の地域が選択されていないと保存できない' do
        @item.delivery_area_id = nil
        expect(@item).to_not be_valid
      end

      it '発送までの日数が選択されていないと保存できない' do
        @item.delivery_day_id = nil
        expect(@item).to_not be_valid
      end

      it '価格が存在しないと保存できない' do
        @item.price = nil
        expect(@item).to_not be_valid
      end

      it '価格が範囲外の場合は保存できない' do
        @item.price = 299
        expect(@item).to_not be_valid
        @item.price = 10_000_000
        expect(@item).to_not be_valid
      end

      it '価格が半角数字以外の場合は保存できない' do
        @item.price = '１０００'
        expect(@item).to_not be_valid

        @item.price = 'abc'
        expect(@item).to_not be_valid
      end
    end
  end
end
