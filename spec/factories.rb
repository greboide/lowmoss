FactoryGirl.define do  
  factory :notification do
    association :user
    active false
    body "MyString"
  end
  factory :post do
    body "MyText"
    association :user
  end

  factory :user do
    email 'test@example.com'

    password 'f4k3p455w0rd'

    # if needed
    # is_active true
  end
end
