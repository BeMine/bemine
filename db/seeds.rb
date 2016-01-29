# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

categories = [
  { :name => '鞋包配件',    :picture => File.new("#{Rails.root}/app/assets/images/categories/accessories.png") },
  { :name => '品牌服飾',    :picture => File.new("#{Rails.root}/app/assets/images/categories/clothings.png") },
  { :name => '3C家電',     :picture => File.new("#{Rails.root}/app/assets/images/categories/electronics.png") },
  { :name => '食品點心',    :picture => File.new("#{Rails.root}/app/assets/images/categories/foods.png") },
  { :name => '化妝／保養品', :picture => File.new("#{Rails.root}/app/assets/images/categories/cosmetics.png") },
  { :name => '其他海外限定', :picture => File.new("#{Rails.root}/app/assets/images/categories/oversea_limited.png") },
]

categories.each do |category|
  Category.create!(:name => category[:name], :picture => category[:picture])
end
