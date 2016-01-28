class DropDetails < ActiveRecord::Migration
  def change
    drop_table :details
  end
end
