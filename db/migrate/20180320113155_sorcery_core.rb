class SorceryCore < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email,            :null => false
      t.string :crypted_password
      t.string :salt

      t.string :name, null: false
      t.string :student_number, null: false
      t.date :birthday, null: false
      t.string :allergy_data, default: ""
      t.string :remark, default: ""
      t.boolean :executive, default: false
      t.integer :role, null: false, default: 0
      
      t.timestamps                :null => false
    end

    add_index :users, :email, unique: true
    add_index :users, :student_number, unique: true
  end
end
