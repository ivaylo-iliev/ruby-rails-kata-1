require 'test_helper'
require 'faker'

class AuthorTest < ActiveSupport::TestCase
  test 'should not save author without email' do
    author = Author.new( 
      first_name: Faker::Name.unique.first_name, 
      last_name: Faker::Name.unique.last_name
    )
    assert_not author.save
  end

  test 'should not save author with invalid email' do
    email = 'test-2133123.oiu'
    author = Author.new(
      email: email, 
      first_name: Faker::Name.unique.first_name,
      last_name: Faker::Name.unique.last_name
    )
    assert_not author.save
  end

  test 'should not save author without first name' do
    author = Author.new( 
      email: Faker::Internet.unique.email, 
      last_name: Faker::Name.unique.last_name
    )
    assert_not author.save
  end

  test 'should not save author without last name name' do
    author = Author.new(
      email: Faker::Internet.unique.email, 
      first_name: Faker::Name.unique.first_name,
    )
    assert_not author.save
  end

  test 'should save valid author' do
    author = Author.new( 
      email: Faker::Internet.unique.email, 
      first_name: Faker::Name.unique.first_name,
      last_name: Faker::Name.unique.last_name
    )
    assert author.save
  end

  test 'should not save author without unique mail' do
    email = Faker::Internet.unique.email
    author1 = Author.new(
      email: email, 
      first_name: Faker::Name.unique.first_name,
      last_name: Faker::Name.unique.last_name
    )
    assert author1.save

    author2 = Author.new(
      email: email,
      first_name: Faker::Name.unique.first_name,
      last_name: Faker::Name.unique.last_name
    )
    assert_not author2.save
  end
end