class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new , :edit]

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
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    if user_signed_in?
      if current_user == @item.user #&& !@item.sold_out?
        render :edit
      else
        redirect_to root_path
      end
    else
      redirect_to new_user_session_path
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  private

  def item_params
    params.require(:item).permit(:product_name, :product_detail, :product_category_id, :product_situation_id, :delivery_charge_id, :delivery_area_id, :delivery_day_id, :price, :image)
          .merge(user_id: current_user.id)
  end
end
