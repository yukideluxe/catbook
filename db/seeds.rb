require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
case Rails.env
when "development"
  1000.times do |i|
    Cat.create!(name: Faker::Name.name, birthday: Faker::Date.birthday)
  end
end
