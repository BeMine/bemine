class Order < ActiveRecord::Base
  validates_presence_of :name, :amount

  belongs_to :user
  has_one :line_item

  def add_line_items(cart)
    cart.line_items.each do |line|
      line_items.build(product: line.product, quantity: line.quantity )
    end

    self.amount = cart.amount
  end
end
