class Address < ActiveRecord::Base
  validates_presence_of :address1, :locality, :region, :country

  belongs_to :addressable, polymorphic: true
end
