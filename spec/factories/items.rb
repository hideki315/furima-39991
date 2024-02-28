FactoryBot.define do
  factory :item do
    product_name { Faker::Team.product_name }
    product_detail { Faker::Lorem.sentence }
    product_category_id { Faker::Number.between(from: 2, to: 10) }
    product_situation_id { Faker::Number.between(from: 2, to: 5) }
    delivery_charge_id { Faker::Number.between(from: 2, to: 3) }
    delivery_area_id { Faker::Number.between(from: 2, to: 47) }
    delivery_day_id { Faker::Number.between(from: 2, to: 3) }
    price { Faker::Commerce.price(range: 100..100000) }
    association :user

    transient do
      with_image { true }
    end

    after(:build) do |item, evaluator|
      if evaluator.with_image
        item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png', content_type: 'image/png')
      end
    end
  end
end
