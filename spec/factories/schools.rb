FactoryBot.define do
  
  # sequence :sub_title do |n|
  #   "Test data #{n}"
  # end
  
  # sequence :name do
  #   "#{Faker::University.name}"
  # end
  
  # sequence :content do |n|
  #   "This is #{n}th Test Data"
  # end
  
  factory :school do
    sub_title { "a" }
    name { Faker::University.name }
    content { "aaaaa" }
    user
  end
  
  factory :most_recent, class: School do
    sub_title { "一番初めに来る" }
    name { "学校（テスト）" }
    user
  end
  
  
end
