class AddProfileTextToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :profile_text, :string
  end
end
