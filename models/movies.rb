require_relative("../db/sql_runner")

class Movie

  attr_accessor :title, :genre, :budget
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @budget = options['budget'].to_i
  end

  def save()
    sql = "INSERT INTO movies
    (title, genre, budget)
    VALUES
    ($1, $2, $3)
    RETURNING id"
    values = [@title, @genre, @budget]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def delete()
    sql = "DELETE FROM movies WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE movies SET
      (title, genre, budget)
      =
      ($1, $2, $3)
      WHERE id = $4"
    values = [@title, @genre, @budget, @id]
    SqlRunner.run(sql, values)
  end

  def stars()
    sql = "SELECT stars.* FROM stars INNER JOIN castings ON castings.star_id = stars.id WHERE movie_id = $1"
    values = [@id]
    stars_data = SqlRunner.run(sql, values)
    return Star.map_all(stars_data)
  end

  def calc_budget
    sql = "SELECT fee FROM castings WHERE movie_id = $1"
    values =[@id]
    all_fees = SqlRunner.run(sql, values)

    total_fees = 0
    all_fees.each { |fee| total_fees += fee["fee"].to_i }
    return @budget -= total_fees
  end

  def self.delete()
    sql = "DELETE FROM movies"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM movies"
    movies = SqlRunner.run(sql)
    return Movie.map_all(movies)
  end

  def self.map_all(movies_data)
    movie = movies_data.map {|movie| Movie.new(movie)}
    return movie
  end

end
