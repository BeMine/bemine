# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

categories = [
  { :name => '鞋包配件',    :picture => File.new("#{Rails.root}/app/assets/images/accessoriesedit.png") },
  { :name => '品牌服飾',    :picture => File.new("#{Rails.root}/app/assets/images/clothingsedit.png") },
  { :name => '3C家電',     :picture => File.new("#{Rails.root}/app/assets/images/electronicsedit.png") },
  { :name => '食品點心',    :picture => File.new("#{Rails.root}/app/assets/images/foodsedit.png") },
  { :name => '化妝／保養品', :picture => File.new("#{Rails.root}/app/assets/images/cosmeticsedit.png") },
  { :name => '其他海外限定', :picture => File.new("#{Rails.root}/app/assets/images/oversea_limitededit.png") },
]

categories.each do |category|
  Category.create!(:name => category[:name], :picture => category[:picture])
end
