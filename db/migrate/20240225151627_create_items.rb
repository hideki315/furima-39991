class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
        t.string :product_name, null: false
        t.text :product_detail, null: false
        t.integer :product_category_id, null: false
        t.integer :product_situation_id, null: false
        t.integer :delivery_charge_id, null: false
        t.integer :delivery_area_id, null: false
        t.integer :delivery_day_id, null: false
        t.integer :price, null: false
        t.references :user, null: false, foreign_key: true
        t.timestamps
    end
  end
end
