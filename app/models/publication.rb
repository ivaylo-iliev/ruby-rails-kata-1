# frozen_string_literal: true

class Publication < ApplicationRecord
  validates :authors, :title, presence: true
  validates :isbn, presence: true, uniqueness: true

  def self.search(search)
    Publication.all if search.nil?

    isbn = Publication.arel_table[:isbn]
    authors = Publication.arel_table[:authors]

    result = Publication.where(isbn.matches("%#{search}%"))
    result = Publication.where(authors.matches("%#{search}%")) if result.empty?
    result = Publication.all if result.empty? || result.nil?

    publications = result
    publications
  end
end
