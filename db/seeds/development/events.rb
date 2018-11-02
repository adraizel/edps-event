dt = Date.today

[true, false].each do |o|
  # ?開催終了
  Event.new(
    {
      title: Faker::Book.title,
      summary: Faker::Lovecraft.sentence,
      description: Faker::Markdown.sandwich(3, 5),
      start_time: dt.last_year,
      join_limit: dt.last_week.last_year,
      owner_id: o ? 1 : rand(1..3),
      official: o
    }
  ).save(validate: false)
  # ?開催前 - 参加受付中
  Event.new(
    {
      title: Faker::Book.title,
      summary: Faker::Lovecraft.sentence,
      description: Faker::Markdown.sandwich(3, 5),
      start_time: dt.next_year,
      join_limit: dt.last_week.next_year,
      owner_id: o ? 1 : rand(1..3),
      official: o
    }
  ).save(validate: false)
  # ?開催前 - 参加受け付け終了
  Event.new(
    {
      title: Faker::Book.title,
      summary: Faker::Lovecraft.sentence,
      description: Faker::Markdown.sandwich(3, 5),
      start_time: dt.next_year,
      join_limit: dt.yesterday,
      owner_id: o ? 1 : rand(1..3),
      official: o
    }
  ).save(validate: false)
  # ?イベント削除済み
  Event.new(
    {
      title: Faker::Book.title,
      summary: Faker::Lovecraft.sentence,
      description: Faker::Markdown.sandwich(3, 5),
      start_time: dt.last_year,
      join_limit: dt.last_week.last_year,
      owner_id: o ? 1 : 2,
      official: o,
      deleted: true
    }
  ).save(validate: false)
end