FactoryBot.define do
  factory :school_chat do
    user { create(:user) }
    school { create(:school) }
    content { "MyText" }
  end
end
