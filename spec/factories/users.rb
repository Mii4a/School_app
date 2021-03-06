FactoryBot.define do
    
    sequence :name, class: User do |n|
        "Test User#{n}"
    end
    
    sequence :email, class: User do |n|
        "test#{n}@user.com"
    end
    
    sequence :unique_name, class: User do |n|
        "test_user#{n}"
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
        # school
        # school_relationships
        
        trait :with_default_schools do
          after(:build) do |user|
              user.schools << build(:school, name: "パリ大学")
              user.schools << build(:school, name: "ボローニャ大学")
          end
        end
        
        trait :with_default_school_relationships do
            after(:build) do |user|
                user.school_relationships << build(:school_relationships)
            end
        end
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
