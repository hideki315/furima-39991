FactoryBot.define do
  factory :order_form do
    post_code { "123-4567" }
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    municipality { Faker::Address.city }
    street_address { Faker::Address.street_address }
    building_name { Faker::Address.building_number } 
    phone_number { "09012341234" }
    token {"tok_abcdefghijk00000000000000000"}
  end
end
