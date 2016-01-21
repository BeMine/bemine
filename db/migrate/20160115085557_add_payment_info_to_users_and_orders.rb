class AddPaymentInfoToUsersAndOrders < ActiveRecord::Migration
  def change
    add_column :users, :payment_info, :string
    add_column :orders, :payment_info, :string
    add_column :orders, :transaction_info, :string
  end
end
