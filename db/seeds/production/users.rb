User.create([
  {
    email: 'admin@edps.com',
    name: 'administrator',
    student_number: 'NE27-9999D',
    birthday: Date.new(1997, 1, 1),
    allergy_data: '',
    remark: 'First User',
    executive: true,
    mailer: true,
    password: ENV['FIRST_ADMIN_PASS'],
    password_confirmation: ENV['FIRST_ADMIN_PASS']
  }
])