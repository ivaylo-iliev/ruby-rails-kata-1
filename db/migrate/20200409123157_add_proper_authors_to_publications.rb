class AddProperAuthorsToPublications < ActiveRecord::Migration[5.2]
  def change
    add_column :publications, :authors, :Text
  end
end
