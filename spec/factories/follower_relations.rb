# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :follower_relation do
    association :cat
    association :followed, factory: :cat
  end
end
