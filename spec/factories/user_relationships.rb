FactoryBot.define do
  factory :user_relationship do
    followed { create(:user) }
    follower { create(:other_user) }
  end
end
