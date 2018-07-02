class CreateEvents < ActiveRecord::Migration[5.1]
  def self.up
    create_table :events do |t|
      t.string   :title
      t.text     :description
      t.boolean  :markdown,     default: false
      t.integer  :charge
      t.string   :location
      t.datetime :start_time
      t.date     :join_limit
      t.integer  :owner_id
      t.boolean  :official,     default: false
      t.boolean  :deleted,      default: false

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
