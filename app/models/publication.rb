# frozen_string_literal: true

class Publication < ApplicationRecord
  validates :authors, :title, presence: true
  validates :isbn, presence: true, uniqueness: true

  def self.search(search)
    Publication.all if search.nil?

    result = Publication.where("isbn LIKE '%#{search}%'")
    result = Publication.where("authors LIKE '%#{search}%'") if result.empty?
    result = Publication.all if result.empty?

    publications = result
    publications
  end
end
