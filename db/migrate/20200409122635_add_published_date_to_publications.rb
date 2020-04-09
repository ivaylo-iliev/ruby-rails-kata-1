# frozen_string_literal: true

class AddPublishedDateToPublications < ActiveRecord::Migration[5.2]
  def change
    add_column :publications, :published_at, :Date
  end
end
