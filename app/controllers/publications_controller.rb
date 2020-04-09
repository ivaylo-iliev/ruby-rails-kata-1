# frozen_string_literal: true

class PublicationsController < ApplicationController
  def index
    @publications = Publication.search(params[:search])
  end

  def upload
    uploaded_file = params['csvfile']
    parse uploaded_file
  end

  def search; end

  def parse(file)
    if file.original_filename.include?('magazine') || file.original_filename.include?('book')
      data = CSV.parse(file.open, col_sep: ';', headers: true)
      t_data = data.map(&:to_hash)
      t_data.each do |row|
        record = Publication.new
        record.title = row['title']
        record.isbn = row['isbn']
        record.authors = row['authors']
        record.published_at = row['publishedAt'] != '' ? row['publishedAt'] : ''
        record.description = row['description'] != '' ? row['description'] : ''

        record.save
      end
      redirect_to(publications_index_path, flash: { notice: 'All done' }) && return
    else
      redirect_to(publications_index_path, flash: { notice: "The file should contain 'magazine' or 'book' in its name" }) && return
    end
  end
end
