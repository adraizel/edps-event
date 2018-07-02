class CreateUserEvents < ActiveRecord::Migration[5.1]
  def self.up
    create_table :user_events do |t|
      t.integer    :user_id,   foreign_key: true
      t.integer    :event_id,  foreign_key: true
      t.text       :remark, default: ''

      t.timestamps
    end
    add_index :user_events, ['user_id', 'event_id'], unique: true
  end

  def self.down
    drop_table :user_events
  end
end
