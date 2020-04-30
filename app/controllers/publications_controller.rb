# frozen_string_literal: true

class PublicationsController < ApplicationController
  def index
    @publications = Publication.search(params[:search])
  end

  def upload
    uploaded_file = params['csvfile']
    parse uploaded_file unless uploaded_file.nil?
  end

  def create_new_record(record_data)
    return if record_data.nil?

    new_publication = Publication.new
    new_publication.title = record_data['title']
    new_publication.isbn = record_data['isbn']
    new_publication.authors = record_data['authors']
    new_publication.published_at = record_data['publishedAt'] || ''
    new_publication.description = record_data['description'] || ''
    new_publication
  end

  def parse(file)
    return unless file.original_filename.include?('magazine') ||
                  file.original_filename.include?('book')

    data_from_file = CSV.parse(file.open, col_sep: ';', headers: true)
    publication_data_map = data_from_file.map(&:to_hash)
    publication_data_map.each do |publication|
      publication_record = create_new_record(publication)
      publication_record&.save
    end

    redirect_to(publications_index_path, flash: { notice: 'All done' })
  end
end
