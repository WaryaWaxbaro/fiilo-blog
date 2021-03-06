# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

1.upto(120).each do |i|
  ran = rand(4)
  role = ["admin", "author", "member"]
  User.create(first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              email: "user#{i}@fiilo.com",
              roles: [role[ran]],
              password: 'secret',
              password_confirmation: 'secret',
              phone: Faker::PhoneNumber.phone_number_with_country_code,
              accept_terms: true)
end

@users = User.all
is_published = [1, 0]
1.upto(200).each do |i|
  ran = rand(119)
  ran_bool = rand(2)
  post = Post.create(title: Faker::Lorem.sentence(word_count: 15),
              intro: Faker::Lorem.paragraph(sentence_count: 10))
  post.user = @users[ran]
  post.slug = "#{post.title}".parameterize
  post.publish = is_published[ran_bool]
  post.publish_at = Date.yesterday
  post.save
end
