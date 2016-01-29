class AddIndexToLineItems < ActiveRecord::Migration
  def change
    add_index :line_items, :cart_id
    add_index :line_items, :order_id
    add_index :line_items, :product_id
  end
end
