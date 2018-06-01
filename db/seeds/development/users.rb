User.create([
  {
    email: 'admin@edps.com',
    name: 'admin',
    student_number: 'NE27-9999D',
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
    birthday: Date.new(1997, 1, 1),
    allergy_data:  '',
    remark: 'user1',
    executive: false,
    mailer: false,
    password: 'password',
    password_confirmation: 'password'
  },
])

allergy_texts = %w(大豆 鶏肉 豚肉 まつたけ プログラミング言語)
number = 12
2.upto number do |n|
  name = Faker::Internet.user_name(Faker::StarWars.character, %w(. _ -))
  User.create({
    email: Faker::Internet.safe_email(name),
    name: name,
    student_number: "NE27-#{n.to_s.rjust(4, '0')}D",
    birthday: Date.new(1997, 1, 1),
    allergy_data: allergy_texts.sample,
    remark: "ナンバー:#{n}",
    executive: false,
    mailer: false,
    password: 'password',
    password_confirmation: 'password'
  })
end
