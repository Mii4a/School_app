FactoryBot.define do
    factory :user , class: User do
        name        { "Example User" }
        email       { "user@example.com" }
        unique_name { "example_user" }
        password    { "password" }
        password_confirmation { "password" }
    end
end