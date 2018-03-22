class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.integer :charge
      t.string :roll_call_point
      t.string :location
      t.datetime :roll_call_time
      t.datetime :start_time
      t.datetime :end_time
      t.datetime :join_limit
      t.references :user
      t.boolean :deleted, default: false
      
      t.timestamps
    end
  end
end
