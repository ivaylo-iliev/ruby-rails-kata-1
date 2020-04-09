# frozen_string_literal: true

require 'csv'

class AuthorController < ApplicationController
  def index
    @authors = Author.all
  end

  def upload
    uploaded_file = params['csvfile']
    parse uploaded_file
  end

  def parse(file)
    if file.original_filename.include?('author')
      data = CSV.parse(file.open, col_sep: ';', headers: true)
      t_data = data.map(&:to_hash)
      t_data.each do |row|
        record = Author.new(
          email: row['email'],
          first_name: row['firstname'],
          last_name: row['lastname']
        )
        record.save
        redirect_to(author_index_path, flash: { notice: 'All done!' }) && return
      end
    else
      redirect_to(author_index_path, flash: { notice: "The file should contain 'author' in its name" }) && return
    end
  end
end
