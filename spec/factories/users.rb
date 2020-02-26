FactoryBot.define do
    factory :user , class: User do
        name        { "Example User" }
        unique_name { "example_user" }
        email       { "user@example.com" }
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