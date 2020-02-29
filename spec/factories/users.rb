FactoryBot.define do
    
    sequence :name do |n|
        "Example User#{n}"
    end
    
    sequence :email do |n|
        "example#{n}@user.com"
    end
    
    sequence :unique_name do |n|
        "example_user#{n}"
    end
    
    factory :user , class: User do
        name
        unique_name
        email
        password    { "password" }
        password_confirmation { "password" }
        admin { true }
    end
    
    factory :other_user, class: User do
        name        { "Other User" }
        unique_name { "otheruser" }
        email       { "other@user.com" }
        password    { "password" }
        password_confirmation { "password" }
    end
    
    factory :other_user2, class: User do
        name        { "Other User" }
        unique_name { "otheruser2" }
        email       { "other2@user.com" }
        password    { "password" }
        password_confirmation { "password" }
    end
    
    factory :invalid_user , class: User do
        name        { "" }
        unique_name { "" }
        email       { "" }
        password    { "" }
        password_confirmation { "" }
    end

end
