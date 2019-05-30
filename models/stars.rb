require_relative("../db/sql_runner")
require_relative("movies")

class Star

  attr_accessor :first_name, :last_name
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
  end

  def save()
    sql = "INSERT INTO stars
    (first_name, last_name)
    VALUES
    ($1, $2)
    RETURNING id"
    values = [@first_name, @last_name]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def delete()
    sql = "DELETE FROM stars WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE stars SET
    (first_name, last_name)
    =
    ($1, $2)
    WHERE id = $3"
    values = [@first_name, @last_name, @id]
    SqlRunner.run(sql, values)
  end

  def movies()
    sql = "SELECT movies.* FROM movies
      INNER JOIN castings ON castings.movie_id = movies.id
      WHERE star_id = $1"
    values = [@id]
    movies_data = SqlRunner.run(sql, values)
    return Movie.map_all(movies_data)
  end

  def self.delete()
    sql = "DELETE FROM stars"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM stars"
    stars = SqlRunner.run(sql)
    return Star.map_all(stars)
  end

  def self.map_all(stars_data)
    star = stars_data.map {|star| Star.new(star)}
    return star
  end

end
