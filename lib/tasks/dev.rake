namespace :dev do
  task fake: :environment do
    puts 'Nuking the db...'

    User.delete_all
    Product.delete_all
    Order.delete_all
    LineItem.delete_all

    puts 'Nuking uploaded images in public/system/products...'

    rm_rf 'public/system/products'

    puts 'Generating users...'

    users = []
    password = 'password'

    users << User.create!(email: 'user@email.com', name: 'Test User', password: password)

    2.times do
      users << User.create!(name: Faker::Name.name, email: Faker::Internet.email, password: password)
    end

    puts 'Generating products...'

    # Download placeholder image
    picture_url = Faker::Placeholdit.image('320x480', 'png', 'cccccc', '959595')
    file = Tempfile.new(['temp', '.jpg'], encoding: 'ascii-8bit')
    string_io = open(picture_url)
    file.write(string_io.read)

    Category.all.each do |category|
      rand(1..20).times do
        category.products.create!(name: Faker::Commerce.product_name, picture: file, price: Faker::Number.between(1, 99999))
      end
    end
  end

  task nuke_images: :environment do
    puts 'Nuking all uploaded images in public/system...'
    rm_rf 'public/system'
  end
end
