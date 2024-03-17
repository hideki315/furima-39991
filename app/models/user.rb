class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :orders

  validates :nick_name, presence: true
  validates :password, length: { minimum: 6 }, format: { with: /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d]{6,}\z/ }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }
  validates :katakana_first_name, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :katakana_last_name, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :birth_day, presence: true
end
