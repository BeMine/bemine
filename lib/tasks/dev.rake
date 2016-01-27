namespace :dev do
  task rebuild: :environment do
    Rake::Task['db:migrate:reset'].invoke
    Rake::Task['db:seed'].invoke
    Rake::Task['dev:fake'].invoke
  end

  task fake: :environment do
    Rake::Task['dev:clean'].invoke

    puts 'Generating users...'

    users = []
    password = 'password'

    user = User.create!(email: 'user@email.com', name: 'Test User', password: password)
    user.create_address(address1: '南京東路二段97號', locality: '中山區', region: '台北市', postcode: '104', country: 'TW')
    users << user

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
        category.products.create!(
          name: Faker::Commerce.product_name,
          description: Faker::Hipster.sentences(3),
          price: Faker::Number.between(1, 99999),
          picture: file,
          location: Faker::Address.country
        )
      end
    end
  end

  task clean: :environment do
    puts 'Cleaning the db...'

    User.delete_all
    Product.delete_all
    Cart.delete_all
    Order.delete_all
    LineItem.delete_all

    puts 'Cleaning uploaded images in public/system/products...'

    rm_rf 'public/system/products'
  end

  task nuke_images: :environment do
    puts 'Nuking all uploaded images in public/system...'
    rm_rf 'public/system'
  end
end
