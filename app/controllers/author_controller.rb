# frozen_string_literal: true

require 'csv'

class AuthorController < ApplicationController
  def index
    @authors = Author.all
  end

  def upload
    uploaded_file = params['csvfile']
    parse uploaded_file unless uploaded_file.nil?
  end

  def create_new_record(record_data)
    return if record_data.nil?

    new_author = Author.new
    new_author.email = record_data['email']
    new_author.first_name = record_data['firstname']
    new_author.last_name = record_data['lastname']
    new_author
  end

  def parse(file)
    return unless file.original_filename.include?('author')

    data_from_file = CSV.parse(file.open, col_sep: ';', headers: true)
    author_data_map = data_from_file.map(&:to_hash)

    author_data_map.each do |author|
      author_record = create_new_record(author)
      author_record&.save
    end

    redirect_to(author_index_path)
  end
end
