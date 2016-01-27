class AddNameToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :name, :string
  end
end
