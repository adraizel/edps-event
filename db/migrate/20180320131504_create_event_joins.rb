class CreateEventJoins < ActiveRecord::Migration[5.1]
  def change
    create_table :event_joins do |t|
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true
      
      t.timestamps
    end
  end
end
