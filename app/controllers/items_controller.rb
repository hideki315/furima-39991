class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def new
    @item = Item.new
    @product_categories = ProductCategory.all
    @product_situations = ProductSituation.all
    @delivery_charges = DeliveryCharge.all
    @delivery_areas = DeliveryArea.all
    @delivery_days = DeliveryDay.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:product_name, :product_detail, :product_category_id, :product_situation_id, :delivery_charge_id, :delivery_area_id, :delivery_day_id, :price, :image)
          .merge(user_id: current_user.id)
  end
end
