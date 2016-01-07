class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
    	t.string :name
    	t.text :description
    	t.boolean :is_public
    	t.integer :capacity

      t.timestamps null: false
    end
  end
end
