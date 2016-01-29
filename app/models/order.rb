class Order < ActiveRecord::Base
  validates_presence_of :name, :amount
  validate :has_line_item, on: [:create, :update]

  belongs_to :user
  belongs_to :fulfiller, class_name: 'User', foreign_key: 'fulfiller_id'

  has_one :line_item
  has_one :shipping_address, class_name: 'Address', as: :addressable
  has_many :fulfill_requests

  accepts_nested_attributes_for :shipping_address, allow_destroy: true, reject_if: :all_blank

  store :transaction_info, accessors: [:bt_transaction_id]

  def accepted?
    !fulfiller_id.nil?
  end

  def has_line_item
    errors.add(:order, 'has no line_item') if line_item.nil?
  end

  def self.build_from_cart(cart, user)
    order = user.orders.new
    order.name = cart.name
    order.build_shipping_address(cart.shipping_address.slice(:address1, :address2, :address3, :locality, :region, :postcode, :country))
    cart.line_item.order = order # TODO: save?
    order.amount = cart.amount
    order
  end
end
