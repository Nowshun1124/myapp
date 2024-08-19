class CreateArtists < ActiveRecord::Migration[7.1]
  def change
    create_table :artists do |t|
      t.text :bio
      t.json :social_links
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
