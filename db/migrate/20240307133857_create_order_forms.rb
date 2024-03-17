class CreateOrderForms < ActiveRecord::Migration[7.0]
  def change
    create_table :order_forms do |t|

      t.timestamps
    end
  end
end
