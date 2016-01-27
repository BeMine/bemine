class Cart < ActiveRecord::Base
  has_one :line_item
  has_one :shipping_address, class_name: 'Address', as: :addressable

  accepts_nested_attributes_for :shipping_address, allow_destroy: true, reject_if: :all_blank

  store :payment_info, accessors: [:bt_payment_method_token]

  def empty?
    line_item.nil?
  end

  def amount
    line_item.product.price * line_item.quantity
  end

  def setup_for_checkout(user)
    self.name = user.name
    if user.address.nil?
      self.build_shipping_address
    else
      self.build_shipping_address(user.address.attributes.merge(id: nil))
    end
  end
end
