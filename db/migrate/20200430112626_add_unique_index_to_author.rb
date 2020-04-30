class AddUniqueIndexToAuthor < ActiveRecord::Migration[5.2]
  def change
    add_index :authors, :email, unique: true
  end
end
