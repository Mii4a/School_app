FactoryBot.define do
  sequence :user do |n|
    create_list(:user, n)
  end
  
  sequence :school do |n|
    create_list(:school, n)
  end
  
  sequence :content do |n|
    "Test Chat #{n}"
  end
  
  factory :school_chat, class: SchoolChat do
    with_default_user
    with_default_school
    content
    
    trait :with_default_user do
      association :user, factory: :user
    end
    
    trait :with_default_school do
      association :school, factory: :school
    end
  end
end
