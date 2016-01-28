class FulfillRequest < ActiveRecord::Base

  validates_presence_of :token

  belongs_to :user
  belongs_to :order

  before_validation :setup_token, :on => :create

  private

  def setup_token
    self.token = SecureRandom.hex(10)
  end

end
