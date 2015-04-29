FactoryGirl.define do

  factory :category do
    name "sadfa"
  end

  sequence :name do |n|
    "category_#{n}"
  end
end
