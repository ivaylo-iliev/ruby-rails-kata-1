class AddUniqueIndexToPublications < ActiveRecord::Migration[5.2]
  def change
    add_index :publications, :isbn, unique: true
  end
end
