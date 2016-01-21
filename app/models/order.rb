class Order < ActiveRecord::Base
  validates_presence_of :name, :amount
  validate :has_line_item, on: [:create, :update]

  belongs_to :user
  has_one :line_item
  has_many :fulfill_requests

  store :transaction_info, accessors: [:bt_payment_method_nonce, :bt_payment_method_token, :bt_transaction_id]

  def add_line_items(cart)
    cart.line_items.each do |line|
      line_items.build(product: line.product, quantity: line.quantity )
    end

    self.amount = cart.amount
  end

  def accepted?
    !fulfiller_id.nil?
  end

  def has_line_item
    if line_item.nil?
      errors.add(:order, 'has no line_item')
    end
  end
end
