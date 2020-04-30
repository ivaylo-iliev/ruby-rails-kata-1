# frozen_string_literal: true

# Handle upload, parse and display of publication (books and magazines) data
class PublicationsController < ApplicationController
  # Read data based on search parameters. If no parameters are passed returns all records
  def index
    @publications = Publication.search(params[:search])
  end

  # Handle upload of csv file
  def upload
    uploaded_file = params['csvfile']
    parse uploaded_file unless uploaded_file.nil?
  end

  # Generate single record of type Publication
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

  # Parse the uploaded csv file and inserts it to the database
  def parse(uploaded_file)
    # Do not proceed in case the file name
    # does not contain the words magazine or book in it
    return unless uploaded_file.original_filename.include?('magazine') ||
                  uploaded_file.original_filename.include?('book')

    # Use ';' for column separator
    data_from_file = CSV.parse(uploaded_file.open, col_sep: ';', headers: true)
    publication_data_map = data_from_file.map(&:to_hash)

    publication_data_map.each do |publication|
      publication_record = create_new_record(publication)
      publication_record&.save # Check if the record is not nil and save it
    end

    redirect_to(publications_index_path)
  end
end
