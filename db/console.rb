require("pry")
require_relative("../models/artist")
require_relative("../models/album")

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({
	'name' => "ABBA"
	})

artist2 = Artist.new({
	'name' => "Donna Summer"
	})

artist3 = Artist.new({
	'name' => "Neil Diamond"
	})

artist1.save()
artist2.save()
artist3.save()

album1 = Album.new({
	'artist_id' => artist1.id,
	'title' => 'Arrival',
	'genre' => 'pop'
	})

album2 = Album.new({
	'artist_id' => artist1.id,
	'title' => 'Bad Girls',
	'genre' => 'disco'
	})

album3 = Album.new({
	'artist_id' => artist1.id,
	'title' => 'Touching You, Touching Me',
	'genre' => 'pop'
	})

album1.save()
album2.save()
album3.save()

binding.pry
nil
