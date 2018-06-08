UserEvent.create!([
  user_id: 1,
  event_id: 2
])
UserEvent.create!([
  user_id: 1,
  event_id: 3
])
UserEvent.create!([
  user_id: 1,
  event_id: 4
])

num = [3, 4, 5, 6, 7, 8, 9, 10, 11]
rem = [""] + %w(一時間遅れます 一時間早く帰ります 30分遅れます 二次会とかありますか?)
1.upto 3 do |t| 
  max = rand(1..6)
  ids = num.shuffle
  1.upto max do
    UserEvent.create!([
      user_id: ids.pop,
      event_id: t,
      remark: rem.sample
    ])
  end
end
