FactoryBot.define do
  factory :school_relationship do
    student { create(:user) }
    school { create(:school) }
    
    trait :with_default_student do
      association :student_id, factory: :user
    end
    
    trait :with_other_student do
      association :student_id, factory: :other_user
    end
    
    trait :with_default_school do
      association :school_id, factory: :school
    end
  end
end
