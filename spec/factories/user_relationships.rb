FactoryBot.define do
  factory :user_relationship do
    followed { create(:other_user) }
    follower { create(:user) }
  end
end
