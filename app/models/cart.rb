class Cart < ActiveRecord::Base
  has_one :line_item

  def amount
    line_items.map(&:amount).sum
  end
end
