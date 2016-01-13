class Cart < ActiveRecord::Base
  has_many :line_items

  def amount
    line_items.map(&:amount).sum
  end

  def add_line_item(product)
    line_item = line_items.find_by(:product_id => product.id)
    if line_item
      line_item.increment!(:quantity)
    else
      line_items.create!(:product => product, :quantity => 1)
    end
  end
end
