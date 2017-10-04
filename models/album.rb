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

# List All Artists/Albums
# in psql
# SELECT artists.*, albums.* FROM artists INNER JOIN albums on artists.id = albums.artist_id;
# OR
# SELECT albums.title, artists.name, albums.genre FROM albums INNER JOIN artists ON artists.id = albums.artist_id;
# if you want to see them without the IDs

	def artists()
		sql = "SELECT * FROM artists WHERE id = $1;"
		values = [@artist_id]
		results = SqlRunner.run(sql, "get_artist", values)
		artist = results[0]
		return Artist.new(artist)
	end

#EDITING AN ALBUM - I'VE COMMENTED THIS OUT SO THAT IT DOESN'T CHANGE IT FOR THE OTHER FUNCTIONS
	# def update()
	# 	sql = "
	# 	UPDATE albums SET (
	# 		artist_id,
	# 		title,
	# 		genre
	# 	) =
	# 	(
	# 		$1, $2, $3
	# 	)
	# 	WHERE id = $4;"
	# 	values = [@artist_id, @title, @genre, @id]
	# 	SqlRunner.run(sql, "update_album", values)
	# end

#DELETING AN ALBUM - I'VE COMMENTED THIS OUT SO THAT IT DOESN'T CHANGE IT FOR THE OTHER FUNCTIONS
	# def delete()
	# 	sql = "DELETE FROM albums WHERE id = $1"
	# 	values = [@id]
	# 	SqlRunner.run(sql, "delete", values)
	# end

	def self.find(id)
		sql = "SELECT * FROM albums WHERE id = $1;"
		values = [id]
		results = SqlRunner.run(sql, "find_album", values)
		album_hash = results.first
		album = Album.new(album_hash)
		return album
	end
	# and typing
	# album2
	# in pry in terminal to get the id (230), then
	# Album.find(230)
	# => #<Album:0x007fd6cf966d58 @artist_id=124, @genre="pop", @id=230, @title="Waterloo">

end
