require_relative '../db/sql_runner'
require_relative 'album'

class Artist

	attr_accessor :name
	attr_reader :id

	def initialize(options)
		@id = options['id'].to_i if options['id']
		@name = options['name']
	end

	def save()
		sql = "INSERT INTO artists
		(
			name
		)
		VALUES
		(
			$1
		)
		RETURNING id;
		"
		values = [@name]
		result = SqlRunner.run(sql, "save_artist", values)
		@id = result[0]['id'].to_i()
	end

	def self.delete_all()
    sql = "DELETE FROM artists"
    values = []
    SqlRunner.run(sql, "delete_all_artists", values)
  end

	def self.all()
    sql = "SELECT * FROM artists"
    values = []
    artists = SqlRunner.run(sql, "all", values)
    return artists.map { |artist| Artist.new(artist) }
  end

	# List All Artists/Albums
	# in psql
	# SELECT artists.*, albums.* FROM artists INNER JOIN albums on artists.id = albums.artist_id;
	# OR
	# SELECT albums.title, artists.name, albums.genre FROM albums INNER JOIN artists ON artists.id = albums.artist_id;
	# if you want to see them without the IDs

	def albums()
		sql = "SELECT * FROM albums WHERE artist_id = $1;"
		values = [@id]
		results = SqlRunner.run(sql, "get_albums", values)
		return results.map { |album| Album.new(album) }
	end

#EDITING THE ARTIST - I'VE COMMENTED THIS OUT SO THAT IT DOESN'T CHANGE IT FOR THE OTHER FUNCTIONS
	# def update()
	# 	sql = "
	# 	UPDATE artists SET (
	# 		name
	# 	) =
	# 	(
	# 		$1
	# 	)
	# 	WHERE id = $2;"
	# 	values = [@name, @id]
	# 	SqlRunner.run(sql, "update_artist", values)
	# end

#DELETING AN ARTIST - I can't quite get this one to work
	# def delete_artist()
	# 	sql = "DELETE FROM artists WHERE id = $1"
	# 	values = [@artist_id]
	# 	SqlRunner.run(sql, "delete_artist", values)
	# end

	def self.find(id)
		sql = "SELECT * FROM artists WHERE id = $1;"
		values = [id]
		results = SqlRunner.run(sql, "find_artist", values)
		artist_hash = results.first
		artist = Artist.new(artist_hash)
		return artist
	end
	# and typing
	# artist1
	# in pry in terminal to get the id (118), then
	# Artist.find(118)
	# => #<Artist:0x007f818bbb7010 @id=118, @name="ABBA">

end
