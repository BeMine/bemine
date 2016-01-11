class AddMatchareaToProductDetail < ActiveRecord::Migration
  def change

  	add_column :products, :matcharea, :string
  end
end
