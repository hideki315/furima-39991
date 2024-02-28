class Category < ActiveHash::Base
  self.data = [
    
  ]

  include ActiveHash::Associations
  has_many :item
end
