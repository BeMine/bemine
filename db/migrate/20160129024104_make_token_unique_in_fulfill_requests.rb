class MakeTokenUniqueInFulfillRequests < ActiveRecord::Migration
  def change
    remove_index :fulfill_requests, :token
    add_index :fulfill_requests, :token, unique: true
  end
end
