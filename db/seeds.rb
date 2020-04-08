# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Users
User.create!(name:        "Example User",
             unique_name: "exampleuser",
             email:       "example@user.com",
             password:              "password",
             password_confirmation: "password",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)
             
99.times do |n|
    name = Faker::Name.name
    unique_name = "example#{ n+1 }"
    email = "example-#{ n+1 }@railstutorial.org"
    password = "password"
    User.create!(name:        name,
                 unique_name: unique_name,
                 email:       email,
                 password:              password,
                 password_confirmation: password,
                 activated: true,
                 activated_at: Time.zone.now)
end

# Schools
users = User.order(:created_at).take(6)
20.times do |n|
    sub_title = "Test data #{n}"
    name = Faker::University.name
    content = "I am number #{n}"
    users.each do |user| 
        user.schools.create!(
            sub_title: sub_title,
            name: name,
            content: content
        )
    end
end

# SchoolRelationships
users = User.all
school = User.first.schools.first
students = users[2..50]
students.each do |student|
    student.enter(school)
end

# SchoolChats
n = 0
students.each do |student|
  n += 1
  content = "test chat #{n}"
  student.school_chats.create!(
    school_id: school.id,
    content: content
  )
end

# UserRelationships
user = User.first
following = users[2..50]
follower = users[3..40]
following.each { |followed| user.follow(followed) }
follower.each { |follower| follower.follow(user) }