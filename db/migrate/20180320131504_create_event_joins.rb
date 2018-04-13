class CreateEventJoins < ActiveRecord::Migration[5.1]
  def change
    create_table :event_joins do |t|
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true
      t.text :remark, default: ""
      
      t.timestamps
    end
    add_index :event_joins, [:user, :event], unique: true
  end
end
