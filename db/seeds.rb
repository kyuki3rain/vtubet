# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!(
  email: "test@example.com",
  password: "aaaa1111",
  name: "テスト"
)

members = []
(1..10).each do |k|
  member = Member.create!(
    name: "テスト#{k}"
  )
  members << member
end

(1..4).each do |t|
  contest = user.contests.create!(
    refund: 1,
    title: "最協決定戦#{t}"
  )
  contest.members = members

  contest.publish!
end