class OrderForm
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :municipality, :street_address, :building_name, :phone_number, :user_id, :item_id, 
                :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :token
    validates :street_address
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :municipality
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }, length: { minimum: 10, maximum: 11 }, allow_blank: false
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def item
    Item.find_by(id: item_id)
  end
  
  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    return false unless order.persisted?

    recipient = Recipient.create(post_code: post_code, prefecture_id: prefecture_id, municipality: municipality, street_address: street_address, building_name: building_name,
                                 phone_number: phone_number, order_id: order.id,)
    recipient.persisted?
  end
end
