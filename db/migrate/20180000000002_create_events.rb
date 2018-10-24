class CreateEvents < ActiveRecord::Migration[5.1]
  def self.up
    create_table :events do |t|
      t.string   :title
      t.text     :summary
      t.text     :description
      t.text     :converted_description
      t.date     :start_time
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
