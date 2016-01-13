class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :cart_id
      t.integer :order_id
      t.integer :product_id, :null => false
      t.integer :quantity, :null => false

      t.timestamps null: false
    end
  end
end
