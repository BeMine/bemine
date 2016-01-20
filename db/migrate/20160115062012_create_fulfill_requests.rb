class CreateFulfillRequests < ActiveRecord::Migration
  def change
    create_table :fulfill_requests do |t|

      t.integer :user_id, :index => true
      t.integer :order_id, :index => true
      t.string  :token, :index => true, :unique => true
      t.timestamps null: false
    end
  end
end
