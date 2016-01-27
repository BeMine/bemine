class RemovePaymentInfoFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :payment_info
  end
end
