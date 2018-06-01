class CreateEventJoins < ActiveRecord::Migration[5.1]
  def self.up
    create_table :event_joins do |t|
      t.integer    :user,   foreign_key: true
      t.integer    :event,  foreign_key: true
      t.text       :remark, default: ''

      t.timestamps
    end
    add_index :event_joins, ['user_id', 'event_id'], unique: true
  end

  def self.down
    drop_table :event_joins
  end
end
