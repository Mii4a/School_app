FactoryBot.define do
  factory :school do
    sub_title { "日本の" }
    name { "学校" }
    user
  end
  
  factory :most_recent, class: School do
    sub_title { "一番初めに来る" }
    name { "学校（テスト）" }
    user
  end
end
