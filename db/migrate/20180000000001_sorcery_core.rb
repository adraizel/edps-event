class SorceryCore < ActiveRecord::Migration[5.1]
  def self.up
    create_table :users do |t|
      t.string  :email,                                          null: false
      t.string  :crypted_password
      t.string  :salt
      t.string  :name,                                           null: false
      t.integer :grade,             default: 1
      t.string  :student_number,                                 null: false
      t.date    :birthday,          default: Date.new(2000,1,1), null: false
      t.string  :allergy_data,      default: ""
      t.string  :remark,            default: ""
      t.boolean :executive,         default: false
      t.boolean :mailer,            default: false

      t.timestamps                                  null: false
    end
    add_index :users, :email,          unique: true
    add_index :users, :student_number, unique: true
  end

  def self.down
    drop_table :users
  end
end
