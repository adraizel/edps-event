Event.create([
  {
    title: Faker::Book.title,
    description: "### Markdown Test\n\n**#{Faker::Lorem.paragraph}**",
    markdown: true,
    charge: rand(0..10000),
    location: Faker::Pokemon.location,
    start_time: Date.today.tomorrow,
    join_limit: Date.today,
    owner_id: 1,
    official: true
  }
])

5.times do
  Event.create([
    {
      title: Faker::Book.title,
      description: Faker::Lovecraft.paragraph,
      charge: rand(0..10000),
      location: Faker::Pokemon.location,
      start_time: Date.today.tomorrow,
      join_limit: Date.today,
      owner_id: rand(1..3)
    }
  ])
end
