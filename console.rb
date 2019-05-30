require_relative("models/castings")
require_relative("models/movies")
require_relative("models/stars")

require('pry')

Star.delete()
Movie.delete()
Casting.delete()

movie1 = Movie.new( {
  'title' => 'Armageddon',
  'genre' => 'Documentary',
  'budget' => 500000
} )
movie1.save()

movie2 = Movie.new( {
  'title' => 'Jurassic Park',
  'genre' => 'Documentary',
  'budget' => 600000
} )
movie2.save()

movie3 = Movie.new({
  'title' => 'Unbreakable',
  'genre' => 'Drama',
  'budget' => 700000
})
movie3.save()

movie4 = Movie.new({
  'title' => 'Kindergarten Cop',
  'genre' => 'Action/Comedy',
  'budget' => 250000
})
movie4.save()

star1 = Star.new({
  'first_name' => 'Arnold',
  'last_name' => 'Schwarzenegger'
})
star1.save()

star2 = Star.new({
  'first_name' => 'Bruce',
  'last_name' => 'Willis'
})
star2.save()

casting1 = Casting.new({
  'movie_id' => movie1.id,
  'star_id' => star2.id,
  'fee' => 1000
})
casting1.save()

casting2 = Casting.new({
  'movie_id' => movie3.id,
  'star_id' => star1.id,
  'fee' => 20000
})
casting2.save()

casting3 = Casting.new({
  'movie_id' => movie3.id,
  'star_id' => star2.id,
  'fee' => 500
})
casting3.save

binding.pry
nil
