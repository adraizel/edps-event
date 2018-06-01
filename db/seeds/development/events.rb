Event.create([
  {
    title: Faker::Book.title,
    description: Faker::Lorem.paragraph,
    charge: rand(0..10000),
    location: Faker::Pokemon.location,
    start_time: Date.today.tomorrow,
    join_limit: Date.today,
    user_id: rand(0..2),
    official: true
  }
])

3.times do
  Event.create([
    {
      title: Faker::Book.title,
      description: Faker::Lovecraft.paragraph,
      charge: rand(0..10000),
      location: Faker::Pokemon.location,
      start_time: Date.today.tomorrow,
      join_limit: Date.today,
      user_id: rand(0..2)
    }
  ])
end
