require 'factory_girl/syntax/blueprint'
require 'factory_girl/syntax/make'

Deck.blueprint do
  title { Faker::Lorem.words(2).join(' ').humanize }
  front_description 'Thai'
  back_description 'English'
  active true
  bulk_cards { 3.times.collect { Faker::Lorem.words(2).join("|") }.join("\n")}
end

User.blueprint do
  username = Faker::Name.name.downcase.gsub(/ /, '_')
  username username
  sequence(:email) {|u| "#{username}@example.com"}
  password 'password'
  password_confirmation 'password'
  admin false
end
