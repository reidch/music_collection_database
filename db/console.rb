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
	'title' => 'Waterloo',
	'genre' => 'pop'
	})

album3 = Album.new({
	'artist_id' => artist2.id,
	'title' => 'Bad Girls',
	'genre' => 'disco'
	})

album4 = Album.new({
	'artist_id' => artist2.id,
	'title' => 'Another Place and Time',
	'genre' => 'disco'
	})

album5 = Album.new({
	'artist_id' => artist3.id,
	'title' => 'Touching You, Touching Me',
	'genre' => 'pop'
	})

album6 = Album.new({
	'artist_id' => artist3.id,
	'title' => 'Beautiful Noise',
	'genre' => 'pop'
	})

album1.save()
album2.save()
album3.save()
album4.save()
album5.save()
album6.save()

#EDITING THE ARTIST - I'VE COMMENTED THIS OUT SO THAT IT DOESN'T CHANGE IT FOR THE OTHER FUNCTIONS
# artist1.name = "Bjorn Again"
# artist1.update()

#EDITING AN ALBUM - I'VE COMMENTED THIS OUT SO THAT IT DOESN'T CHANGE IT FOR THE OTHER FUNCTIONS
# album4.genre = "pop"
# album4.update()

#DELETING AN ARTIST - I can't quite get this one to work - ask about this.
# artist3.delete_artist()

#DELETING AN ALBUM - I'VE COMMENTED THIS OUT SO THAT IT DOESN'T CHANGE IT FOR THE OTHER FUNCTIONS
# album1.delete()

binding.pry
nil
