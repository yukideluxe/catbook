# More info
# http://guides.rubyonrails.org/command_line.html#rake

require 'benchmark'

namespace :catbook do
  desc "Seed follower_relations database with random data"
  task seed_follower_relations: :environment do
    time = Benchmark.measure do
      1000.times do |i|
        cat = Cat.order("RANDOM()").first

        next if FollowerRelation.where(cat_id: cat.id).any?

        # select vs pluck? Benefits?
        others = Cat.where("id <> ?", cat.id).order("RANDOM()").limit(rand(5..100)).pluck(:id)

        others.each do |followed_cat_id|
          FollowerRelation.create(cat_id: cat.id, followed_cat_id: followed_cat_id)
          FollowerRelation.create(cat_id: followed_cat_id, followed_cat_id: cat.id)
        end
      end
    end.real
    puts "\n%s: Seed follower_relations database: (real: %0.6f)\n" % [Time.now, time]
  end
end
