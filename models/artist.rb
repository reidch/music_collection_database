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

	def albums()
		sql = "SELECT * FROM albums WHERE artist_id = $1;"
		values = [@id]
		results = SqlRunner.run(sql, "get_albums", values)
		return results.map { |album| Album.new(album) }
	end
end
