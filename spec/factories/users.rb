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
        admin      { true }
        activated  { true }
        activated_at { Time.zone.now }
    end
    
    factory :other_user, class: User do
        name        { "Other User" }
        unique_name { "otheruser" }
        email       { "other@user.com" }
        password    { "password" }
        password_confirmation { "password" }
        activated  { true }
        activated_at { Time.zone.now }
    end
    
    factory :non_activated_user, class: User do
        name        { "Other User" }
        unique_name { "otheruser2" }
        email       { "other2@user.com" }
        password    { "password" }
        password_confirmation { "password" }
        activated  { false }
        activated_at { Time.zone.now }
    end
    
    factory :invalid_user , class: User do
        name        { "" }
        unique_name { "" }
        email       { "" }
        password    { "" }
        password_confirmation { "" }
    end

end
