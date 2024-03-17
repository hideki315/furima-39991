class Order < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :recipient, dependent: :destroy

  after_create :update_item_sold_out_flag

  private

  def update_item_sold_out_flag
    item.update(sold_out: true)
  end
end