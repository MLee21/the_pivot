FactoryGirl.define do

  factory :user do
    full_name     'MyName'
    email         'example@email.com'
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

  factory :admin2, class: User do
    full_name     'Admin'
    email         'busadmin@email.com'
    role          1
    display_name  'busadmin'
    password      'p'
  end

end
