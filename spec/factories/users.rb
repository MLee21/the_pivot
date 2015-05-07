FactoryGirl.define do

  factory :user do
    full_name     'MyName'
    email         'example@email.com'
    role          0
    display_name  'kulio'
    password      'p'
  end

  factory :admin, class: User do
    full_name     'MyName'
    email         'admin@email.com'
    role          1
    display_name  'admin'
    password      'p'
  end

end
