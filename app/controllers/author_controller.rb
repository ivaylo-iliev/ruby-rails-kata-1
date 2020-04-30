# frozen_string_literal: true

require 'csv'

# Class to handle parse and upload of csv files for authors data
class AuthorController < ApplicationController
  def index
    # Load all data on page load
    @authors = Author.all
  end

  # Handle upload of csv file
  def upload
    uploaded_file = params['csvfile']
    parse uploaded_file unless uploaded_file.nil?
  end

  # Generate single record of type Author
  def create_new_record(record_data)
    return if record_data.nil?

    new_author = Author.new
    new_author.email = record_data['email']
    new_author.first_name = record_data['firstname']
    new_author.last_name = record_data['lastname']
    new_author
  end

  # Parse the uploaded csv file and inserts it to the database
  def parse(uploaded_file)
    # Do not proceed in case the file name does not contain the word author in it
    return unless uploaded_file.original_filename.include?('author')

    # Use ';' for column separator
    data_from_file = CSV.parse(uploaded_file.open, col_sep: ';', headers: true)
    author_data_map = data_from_file.map(&:to_hash)

    author_data_map.each do |author|
      author_record = create_new_record(author)
      author_record&.save # Check if the record is not nil and save it
    end

    redirect_to(author_index_path)
  end
end
