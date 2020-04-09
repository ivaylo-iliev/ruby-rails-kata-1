class RemoveTextFromPublications < ActiveRecord::Migration[5.2]
  def change
    remove_column :publications, :Text, :string
  end
end
