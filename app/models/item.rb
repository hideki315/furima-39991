class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :product_category
  belongs_to :product_situation
  belongs_to :delivery_charge
  belongs_to :delivery_area
  belongs_to :delivery_day
  has_one_attached :image

  validate :image_attached
  validates :product_name, presence: true
  validates :product_detail, presence: true
  validates :product_category_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :product_situation_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :delivery_charge_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :delivery_area_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :delivery_day_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :price, presence: true
  validate :price_within_range

  def user=(user)
    self.user_id = user.id
  end

  private

  def image_attached
    errors.add(:image, "can't be blank") unless image.attached?
  end

  def price_within_range
    if price.present? && !price.between?(300, 9999999)
      errors.add(:price, 'must be between ¥300 and ¥9,999,999')
    end
  end
end