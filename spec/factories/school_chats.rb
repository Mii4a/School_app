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
    user
    school
    content
  end
end
