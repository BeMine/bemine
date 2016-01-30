# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Users

puts 'Seeding users'

password = 'password'

users = [
  { email: 'admin@email.com', name: 'Admin', password: password, role: 'admin' },
  { email: 'alphabt@gmail.com', name: 'Brian', password: password },
  { email: 'briantai@outlook.com', name: 'Brian (Outlook)', password: password },
  { email: 'iczman04@yahoo.com', name: 'Brian (Yahoo)', password: password },
  { email: 'zowie7912@hotmail.com', name: 'Stanley', password: password },
]

users.each do |user|
  u = User.create!(
    email: user[:email],
    name: user[:name],
    password: user[:password],
    role: user[:role]
  )
  u.create_address(
    address1: '南京東路二段97號',
    locality: '中山區',
    region: '台北市',
    postcode: '104',
    country: 'TW'
  )
end

# Categories

puts 'Seeding categories'

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
