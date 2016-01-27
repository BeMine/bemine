class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address1
      t.string :address2
      t.string :address3
      t.string :locality
      t.string :region
      t.string :postcode
      t.string :country
      t.references :addressable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
