FactoryGirl.define do 
  factory :item do 
    title 
    description
    price 200
  end

  sequence :title do |n|
    "hotdog_#{n}"
  end

  sequence :description do |n|
    "hotdog_description_#{n}"
  end
end