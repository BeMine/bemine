namespace :dev do
  task rebuild: :environment do
    Rake::Task['dev:nuke_images'].invoke
    Rake::Task['db:migrate:reset'].invoke
    Rake::Task['db:seed'].invoke
  end

  task demo: :environment do
    Rake::Task['dev:clean'].invoke

    puts 'Generating products...'

    products = [
      {
        name: 'iRobot Roomba 吸塵器',
        picture: File.new("#{Rails.root}/app/assets/images/products/iRobot_Roomba.jpg"),
        price: '8000',
        location: '韓國',
        category_id: 3
      },
      {
        name: 'Dyson DC37 吸塵器',
        picture: File.new("#{Rails.root}/app/assets/images/products/Dyson_DC37.jpg"),
        price: '25000',
        location: '日本',
        category_id: 3
      },
      {
        name: 'Makita DCL180Z 吸塵器',
        picture: File.new("#{Rails.root}/app/assets/images/products/Makita_DCL180Z.jpg"),
        price: '14000',
        location: '新加坡',
        category_id: 3
      },
      {
        name: 'Breeze Cyclonic 吸塵器',
        picture: File.new("#{Rails.root}/app/assets/images/products/Breeze_Cyclonic.jpg"),
        price: '15000',
        location: '美國',
        category_id: 3
      },
      {
        name: 'Dyson HP01 電風扇',
        picture: File.new("#{Rails.root}/app/assets/images/products/Dyson_HP01.jpg"),
        price: '10000',
        location: '日本',
        category_id: 3
      },
    ]

    products.each do |product|
      Product.create!(
        name: product[:name],
        picture: product[:picture],
        price: product[:price],
        location: product[:location],
        category_id: product[:category_id]
      )
    end
  end

  task fake: :environment do
    Rake::Task['dev:clean'].invoke

    # puts 'Generating users...'

    # users = []
    # password = 'password'

    # user = User.create!(
    #   email: 'user@email.com',
    #   name: 'Test User',
    #   password: password,
    #   role: 'admin'
    # )
    # user.create_address(
    #   address1: '南京東路二段97號',
    #   locality: '中山區',
    #   region: '台北市',
    #   postcode: '104',
    #   country: 'TW'
    # )
    # users << user

    # 2.times do
    #   user = User.create!(
    #     name: Faker::Name.name,
    #     email: Faker::Internet.email,
    #     password: password
    #   )
    #   user.create_address(
    #     address1: Faker::Address.street_address,
    #     locality: Faker::Address.city,
    #     region: Faker::Address.state,
    #     postcode: Faker::Address.zip,
    #     country: 'TW'
    #   )
    #   users << user
    # end

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
          description: Faker::Hipster.paragraph(3),
          price: Faker::Number.between(1, 99999),
          picture: file,
          location: Faker::Address.country
        )
      end
    end
  end

  task clean: :environment do
    puts 'Cleaning the db...'

    Product.delete_all
    Cart.delete_all
    Order.delete_all
    LineItem.delete_all
    FulfillRequest.delete_all

    puts 'Cleaning product images...'
    rm_rf 'public/system/products'

    puts 'Cleaning emails in letter_opener...'
    rm_rf 'tmp/letter_opener'
  end

  task nuke_images: :environment do
    puts 'Nuking all uploaded images in public/system...'
    rm_rf 'public/system'
  end
end
