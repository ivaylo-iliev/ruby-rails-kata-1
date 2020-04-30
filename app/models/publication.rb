# frozen_string_literal: true

class Publication < ApplicationRecord
  validates :authors, :title, presence: true
  validates :isbn, presence: true, uniqueness: true

  def self.search(search)
    Publication.all if search.empty?

    isbn = Publication.arel_table[:isbn]
    authors = Publication.arel_table[:authors]

    result = Publication.where(isbn.matches("%#{search}%"))
    if result.empty?
      result = Publication.where(authors.matches("%#{search}%"))
    end
    publications = result || Publication.all
    publications
  end
end
