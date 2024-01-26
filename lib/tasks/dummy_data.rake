namespace :green_it do
  desc "Generate Dummy Data"
  task generate_dummy_data: :environment do
    puts 'Generating users...'
    users = 100.times.map do
      email = Faker::Internet.email
      continue if User.where(email: email).exists?

      password = Faker::Internet.password
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      slug = "#{first_name}-#{last_name}".downcase.gsub(/\W+/, "-")
      profile_pic_url = Faker::Avatar.image(slug: slug, size: "50x50")

      User.create!(
        email: email,
        password: password,
        password_confirmation: password,
        first_name: first_name,
        last_name: last_name,
        profile_pic_url: profile_pic_url
      )
    end

    puts 'Generating posts...'
    users.each do |user|
      post_count = Random.random_number(50)
      post_count.times do 
        body = [
          Faker::Quote.yoda, 
          Faker::Quote.fortune_cookie, 
          Faker::Quote.matz, 
          Faker::Quote.most_interesting_man_in_the_world
        ].join("\n")
        user.posts.create!(
          title: Faker::Movie.title,
          body: body,
          geo_location: [Faker::Address.latitude, Faker::Address.longitude]
        )
      end
    end
  end
end
