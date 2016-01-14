class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id, :index => true
      t.string :name
      t.string :email
      t.string :address
      t.integer :amount
      t.string :status
      t.string :payment_status
      t.string :shipping_status

      t.timestamps null: false
    end
  end
end
