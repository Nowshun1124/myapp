class CreateLives < ActiveRecord::Migration[7.1]
  def change
    create_table :lives do |t|
      t.references :artist, null: false, foreign_key: true
      t.datetime :scheduled_at, null: false
      t.text :description
      t.timestamps
    end
    
  end
end
