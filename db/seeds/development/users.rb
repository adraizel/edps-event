User.create([
  {
    email: 'admin@edps.com',
    name: 'admin',
    student_number: 'NE27-9999D',
    grade: 4,
    birthday: Date.new(1997, 1, 1),
    allergy_data: '',
    remark: 'admin',
    executive: true,
    mailer: true,
    password: 'password',
    password_confirmation: 'password'
  }, {
    email: 'user1@edps.com',
    name: 'user1',
    student_number: 'NE27-0001D',
    grade: 4,
    birthday: Date.new(1997, 1, 1),
    allergy_data:  '',
    remark: 'user1',
    executive: false,
    mailer: false,
    password: 'password',
    password_confirmation: 'password'
  },
])

allergy_texts = %w(大豆 鶏肉 豚肉 松茸 プログラミング言語)
number = 12
2.upto number do |n|
  name = Faker::Internet.user_name(Faker::StarWars.character, %w(. _ -))
  delta = n % 4
  grd = 27 + delta
  User.create({
    email: Faker::Internet.safe_email(name),
    name: name,
    student_number: "NE#{grd}-#{n.to_s.rjust(4, '0')}D",
    grade: 4 - delta,
    birthday: Date.new(1997, 1, 1),
    allergy_data: allergy_texts.sample,
    remark: "ナンバー:#{n}",
    executive: false,
    mailer: false,
    password: 'password',
    password_confirmation: 'password'
  })
end
