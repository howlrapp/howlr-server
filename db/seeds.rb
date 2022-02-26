puts "Populate the database\n"
Rake::Task['db:populate'].invoke

puts "Remove all existing users"
User.destroy_all

puts "Remove all existing reports"
Report.destroy_all

puts "Remove all existings events"
Event.destroy_all

puts "Remove all existings bans"
Ban.destroy_all

groups = Group.all.to_a
genders = Gender.all.to_a
sexual_orientations = SexualOrientation.all.to_a
match_kinds = MatchKind.all.to_a
event_categories = EventCategory.all.to_a

users_count = (ENV["USERS_COUNT"] || 1_000).to_i
puts "\nCreate #{users_count} users"
users = users_count.times.map do |index|
  print "\r#{((index + 1) / users_count.to_f * 100).round}%"

  FactoryBot.create(:user, {
    latitude: rand(-90.0..90.0),
    longitude: rand(-180.0..180.0),
    groups: groups.sample(rand(30)),
    genders: genders.sample(rand(3)),
    sexual_orientations: sexual_orientations.sample(3),
    match_kinds: match_kinds.sample(rand(match_kinds.count)),
    like: Faker::Lorem.sentence,
    dislike: Faker::Lorem.sentence
  }).tap do |user|
    user.update(localities: Geometry.find_localities(user.lonlat.latitude, user.lonlat.longitude)[:localities])
  end
end

puts "\n\nCreate likes"
users.each.with_index do |user, index|
  print "\r#{((index + 1) / users_count.to_f * 100).round}%"

  user.liked_ids = (users.sample(rand(100)).map(&:id) - [user.id])
  user.save!
end

puts "\n\nCreate chats"
users.each.with_index do |user, index|
  print "\r#{((index + 1) / users_count.to_f * 100).round}%"

  rand(20).times do |chat_index|
    FactoryBot.create(:chat, {
      sender: user,
      recipient: users.sample,
      match_kind: match_kinds.sample,
      accepted_at: [ rand(10).days.ago, nil ].sample
    })
  end
end

events_count = (users_count / 10 + 1)
puts "\n\nCreate #{events_count} events"
events_count.times do |index|
  print "\r#{((index + 1) / events_count.to_f * 100).round}%"

  FactoryBot.create :event, {
    user: users.sample,
    event_category: event_categories.sample,
    privacy_status: ["open", "liked_only"].sample,
    users: users.sample(rand(50))
  }
end

reports_count = (users_count / 100 + 1)
puts "\n\nCreate #{reports_count} reports and bans"
reports_count.times do |index|
  print "\r#{((index + 1) / reports_count.to_f * 100).round}%"

  user = users.sample
  FactoryBot.create :report, reporter: users.sample, subject: user

  if [true, false].sample
    FactoryBot.create :ban, {
      user: user,
      banned_until: [rand(12).months.from_now, nil ].sample,
      notification_message: Faker::Lorem.sentence
    }
  end
end

puts "\n\nAll done! Here are a few codes you can use to sign-up:"

[users_count, 15].min.times do
  session = Session.create(user: users.sample)
  session.update(code_expiration_date: 100.years.from_now)

  puts session.code
end