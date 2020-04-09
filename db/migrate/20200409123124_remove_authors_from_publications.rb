class RemoveAuthorsFromPublications < ActiveRecord::Migration[5.2]
  def change
    remove_column :publications, :authors, :string
  end
end
