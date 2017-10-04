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

	def self.all()
    sql = "SELECT * FROM albums"
    values = []
    albums = SqlRunner.run(sql, "all", values)
    return albums.map { |album| Album.new(album) }
  end

	def artists()
		sql = "SELECT * FROM artists WHERE id = $1;"
		values = [@artist_id]
		results = SqlRunner.run(sql, "get_artist", values)
		artist = results[0]
		return Artist.new(artist)
	end

end
