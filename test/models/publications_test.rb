require 'test_helper'
require 'faker'

class AuthorTest < ActiveSupport::TestCase
  test 'should not save publication without ISBN' do
    publication = Publication.new(
      authors: Faker::Internet.unique.email,
      title: Faker::Book.title
    )
    assert_not publication.save
  end

  test 'should not save publication without title' do
    publication = Publication.new(
      authors: Faker::Internet.unique.email,
      isbn: Faker::Code.unique.isbn
    )
    assert_not publication.save
  end

  test 'should not save publication without authors' do
    publication = Publication.new(
      isbn: Faker::Code.unique.isbn,
      title: Faker::Book.title
    )
    assert_not publication.save
  end

  test 'should save publication with isbn, author and title' do
    publication = Publication.new(
      isbn: Faker::Code.unique.isbn,
      authors: Faker::Internet.unique.email,
      title: Faker::Book.title
    )
    assert publication.save
  end

  test 'should not save publication with duplicate ISBN' do
    isbn = Faker::Code.unique.isbn
    publication1 = Publication.new(
      isbn: isbn,
      authors: Faker::Internet.unique.email,
      title: Faker::Book.title
    )
    assert publication1.save

    publication2 = Publication.new(
      isbn: isbn,
      authors: Faker::Internet.unique.email,
      title: Faker::Book.title
    )
    assert_not publication2.save
  end

  test 'should return all results if no search term specified' do
    i = 0
    while i < 10
      Publication.new(
        isbn: Faker::Code.unique.isbn,
        authors: Faker::Internet.unique.email,
        title: Faker::Book.title,
        description: Faker::Lorem.unique.paragraph
      ).save

      i += 1
    end
    assert Publication.search('').size == 10
  end

  test 'should search by ISBN' do
    isbn = Faker::Code.unique.isbn
    Publication.new(
      isbn: isbn,
      authors: Faker::Internet.unique.email,
      title: Faker::Book.title,
      description: Faker::Lorem.unique.paragraph
    ).save

    i = 0
    while i < 9
      Publication.new(
        isbn: Faker::Code.unique.isbn,
        authors: Faker::Internet.unique.email,
        title: Faker::Book.title,
        description: Faker::Lorem.unique.paragraph
      ).save

      i += 1
    end
    assert Publication.search(isbn).size == 1
  end

  test 'should search by author' do
    author = Faker::Internet.unique.email
    Publication.new(
      isbn: Faker::Code.unique.isbn,
      authors: author,
      title: Faker::Book.title,
      description: Faker::Lorem.unique.paragraph
    ).save

    i = 0
    while i < 9
      Publication.new(
        isbn: Faker::Code.unique.isbn,
        authors: Faker::Internet.unique.email,
        title: Faker::Book.title,
        description: Faker::Lorem.unique.paragraph
      ).save

      i += 1
    end
    assert Publication.search(author).size == 1
  end
end
