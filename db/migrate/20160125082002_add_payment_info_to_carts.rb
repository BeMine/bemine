class AddPaymentInfoToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :payment_info, :string
  end
end
