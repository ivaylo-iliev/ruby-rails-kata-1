# frozen_string_literal: true

class Publication < ApplicationRecord
  def self.search(search)
    if search
      isbn = Publication.arel_table[:isbn]
      authors = Publication.arel_table[:authors]

      result = Publication.where(isbn.matches("%#{search}%"))

      if result.empty?
        result = Publication.where(authors.matches("%#{search}%"))
      end

      @publications = result || Publication.all
    else
      @publications = Publication.all
    end
  end
end
