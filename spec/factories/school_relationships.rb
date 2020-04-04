FactoryBot.define do
  factory :school_relationship, class: SchoolRelationship do
    student { create(:user) }
    school { create(:school) }
  end
end
