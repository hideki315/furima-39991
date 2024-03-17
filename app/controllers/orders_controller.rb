class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :new]
  before_action :check_sold_out, only: [:index, :new]
  before_action :check_owner, only: [:index, :new]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_form = OrderForm.new
    @order = Order.new
  end

  def new
    if user_signed_in?
      @order_form = OrderForm.new
    else
      redirect_to new_user_session_path
    end
  end

  def create
    @order_form = OrderForm.new(order_params)
    @item = Item.find_by(id: params[:item_id])
    if @order_form.valid?
      pay_item
      @order_form.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,  
      card: order_params[:token],   
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def check_sold_out
    if @item.sold_out?
      redirect_to root_path
    end
  end

  def check_owner
    redirect_to root_path if current_user == @item.user
  end
  
  def order_params
    params.require(:order_form).permit(:post_code, :prefecture_id, :municipality, :street_address, :building_name, :phone_number).merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token])
  end
end
