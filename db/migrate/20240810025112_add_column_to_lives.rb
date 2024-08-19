class AddColumnToLives < ActiveRecord::Migration[7.1]
  def change
    add_column :lives, :latitude, :float
    add_column :lives, :longitude, :float
  end
end
