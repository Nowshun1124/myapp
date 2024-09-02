class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.text :message
      t.references :artist, null: false, foreign_key: true
      t.timestamps
    end
    add_index :notifications, [:artist_id, :created_at]
  end
end
