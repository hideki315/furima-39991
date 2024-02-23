class AddKatakaneFirstNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :katakane_first_name, :string
  end
end
