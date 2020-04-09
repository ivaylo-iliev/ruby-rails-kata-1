class CreatePublications < ActiveRecord::Migration[5.2]
  def change
    create_table :publications do |t|
      t.string :title
      t.string :isbn
      t.string :authors
      t.string :Text
      t.string :description
      t.string :Text

      t.timestamps
    end
  end
end
