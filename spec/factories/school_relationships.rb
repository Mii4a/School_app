FactoryBot.define do
  factory :school_relationship do
    student { create(:user) }
    school { create(:school) }
  end
end
