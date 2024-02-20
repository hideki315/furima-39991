# テーブル設計

# users
|Column                     |Type                   |Options                                     |
|---------------------------|-----------------------|--------------------------------------------|
|nick_name                  |string                 |null: false                                 |
|email                      |string                 |null: false, , unique: true　　　　　　　     |
|encrypted_password         |string                 |null: false, 　　　　　　　                   |
|first_name                 |string                 |null: false,                                |
|last_name                  |string                 |null: false,                                |
|katakana_first_name        |string                 |null: false,                                |
|katakana_last_name         |string                 |null: false,                                |
|birth_day                  |date                   |null: false,                                |
# Association
has_many: items
has_many: orders


# recipients
|Column                     |Type                   |Options                                     |
|post_code                  |string                 |null: false                                 |
|prefecture_id              |integer                |null: false                                 |
|municipality               |string                 |null: false                                 |
|street_address             |string                 |null: false                                 |
|building_name              |string                 |                                            |
|phone_number               |string                 |null: false                                 |
|order                      |references             |null: false, foreign_key: true              |
# Association
belongs_to: order


## orders
|Column                     |Type                   |Options                                     |
|user                       |references             |null: false, foreign_key: true              |
|item                       |references             |null: false, foreign_key: true              |
# Association
belongs_to: user
belongs_to: item
has_one: recipient


# items
|Column                     |Type                   |Options                                     |
|product_name               |sting                  |null: false                                 |
|product_detail             |text                   |null: false                                 |
|product_category_id        |integer                |null: false                                 |
|product_situation_id       |integer                |null: false                                 |
|delivery_charge_id         |integer                |null: false                                 |
|delivery_area_id           |integer                |null: false                                 |
|delivery_day_id            |integer                |null: false                                 |
|price                      |integer                |null: false                                 |
|user                       |references             |null: false, foreign_key: true              |
# Association
has_one: order
belongs_to: user
