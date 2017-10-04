require_relative '../db/sql_runner'
require_relative 'artist'

class Album

	attr_accessor :artist_id, :title, :genre
  attr_reader :id

	def initialize(options)
		@artist_id = options['artist_id'].to_i
		@id = options['id'].to_i if options['id']
		@title = options['title']
		@genre = options['genre']
	end

	def save()
    sql = "INSERT INTO albums
    (
      artist_id,
      title,
      genre
    ) VALUES
    (
      $1, $2, $3
    )
    RETURNING id;"
    values = [@artist_id, @title, @genre]
    @id = SqlRunner.run(sql, "save", values)[0]["id"].to_i

  end

	def self.delete_all()
		sql = "DELETE FROM albums;"
		values = []
		SqlRunner.run(sql, "delete_all_albums", values)
	end






end
