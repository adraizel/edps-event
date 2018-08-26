email_addr = ENV['FIRST_ADMIN_EMAIL'] || 'admin@edps.com'
User.create(
  email: email_addr,
  name: 'administrator',
  student_number: 'NE27-0999D',
  grade: 4,
  birthday: Date.new(1997, 1, 1),
  allergy_data: '',
  remark: 'First User',
  executive: true,
  mailer: true,
  password: ENV['FIRST_ADMIN_PASS'],
  password_confirmation: ENV['FIRST_ADMIN_PASS']
)