# More info
# http://guides.rubyonrails.org/command_line.html#rake
# http://railscasts.com/episodes/66-custom-rake-tasks

require 'benchmark'
require 'faker'

namespace :catbook do
  desc "Seed cats database"
  task seed_cats_database: :environment do
    if Rails.env == "development"
      time = Benchmark.measure do
        1000.times do |i|
          Cat.create!(name: Faker::Name.name, birthday: Faker::Date.birthday, visible: true)
        end
      end.real
      puts "\n%s: Seed cats database: (real: %0.6f)\n" % [Time.now, time]
    else
      puts "\nTask not meant to be run in other environment but development"
    end
  end

  desc "Seed follower_relations database with random data"
  task seed_follower_relations: :environment do
    if Rails.env == "development"
      time = Benchmark.measure do
        1000.times do |i|
          cat = Cat.order("RANDOM()").first

          next if FollowerRelation.where(cat_id: cat.id).any?

          # select vs pluck? Benefits?
          others = Cat.where("id <> ?", cat.id).order("RANDOM()").limit(rand(5..100)).pluck(:id)

          others.each do |followed_cat_id|
            FollowerRelation.create(cat_id: cat.id, followed_cat_id: followed_cat_id, created_at: 1.month.ago, updated_at: 1.month.ago)
            FollowerRelation.create(cat_id: followed_cat_id, followed_cat_id: cat.id, created_at: 1.month.ago, updated_at: 1.month.ago)
          end
        end
      end.real
      puts "\n%s: Seed follower_relations database: (real: %0.6f)\n" % [Time.now, time]
    else
      puts "\nTask not meant to be run in other environment but development"
    end
  end
end
