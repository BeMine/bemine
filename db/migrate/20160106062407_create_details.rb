class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details do |t|

      t.string :content
      t.integer :quantity
      t.string :size	

      t.timestamps null: false
    end
  end
end
