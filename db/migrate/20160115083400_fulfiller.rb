class Fulfiller < ActiveRecord::Migration
  def change

  	add_column :orders, :fulfiller_id, :integer
  	add_index :orders, :fulfiller_id
  end
end
