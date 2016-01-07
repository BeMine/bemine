class AddPriceLocationToProduct < ActiveRecord::Migration
  def change

  	add_column :products, :location, :string
  	add_column :products, :price, :integer
  end
end
