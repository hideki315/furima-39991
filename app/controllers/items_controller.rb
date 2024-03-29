class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :find_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    if user_signed_in?
      if current_user == @item.user
        @show_edit_and_delete_buttons = true
      elsif Order.exists?(item_id: @item.id, user_id: current_user.id)
        @hide_buttons = true
      else
        @hide_purchase_button = true
      end
    else
      @hide_buttons = true
    end
  end


  def edit
    if current_user == @item.user && !@item.sold_out?
      render :edit
    else
      redirect_to root_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy if current_user == @item.user
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:product_name, :product_detail, :product_category_id, :product_situation_id, :delivery_charge_id, :delivery_area_id, :delivery_day_id, :price, :image)
          .merge(user_id: current_user.id)
  end

  def find_item
    @item = Item.find(params[:id])
  end
end

