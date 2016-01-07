class AddPicToCategory < ActiveRecord::Migration
  def change
  
    add_attachment :categories, :picture  

  end
end
