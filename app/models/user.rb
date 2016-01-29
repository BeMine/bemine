class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, :omniauth_providers => [:facebook]

  validates_presence_of :name, :email

  # TODO: Add validation of role

  has_one :address, as: :addressable
  has_many :orders
  has_many :fulfill_requests

  store :payment_info, accessors: [:bt_customer_id]

  def self.notify_fulfiller!(order)
    self.find_each do |user|
      if user != order.user
        fulfill_request = user.fulfill_requests.create!(user: user, order: order)
        UserMailer.notify_match(user, order, fulfill_request).deliver_later!
      end
    end
  end

  def display_name
    name || email
  end

  def self.from_omniauth(auth)
    # Case 1: Find existing user by facebook uid
    user = User.find_by_fb_uid(auth.uid)
    if user
      user.fb_token = auth.credentials.token
      user.save!
      return user
    end

    # Case 2: Find existing user by email
    existing_user = User.find_by_email(auth.info.email)
    if existing_user
      existing_user.fb_uid = auth.uid
      existing_user.fb_token = auth.credentials.token
      existing_user.name = auth.info.name
      existing_user.save!
      return existing_user
    end

    # Case 3: Create new password
    user = User.new
    user.fb_uid = auth.uid
    user.fb_token = auth.credentials.token
    user.email = auth.info.email
    user.name = auth.info.name
    user.password = Devise.friendly_token[0, 20]
    user.save!
    return user
  end

  def admin?
    role == 'admin'
  end
end
