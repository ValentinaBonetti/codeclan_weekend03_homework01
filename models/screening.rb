require_relative("../db/sql_runner")

class Screening

  attr_reader :id
  attr_accessor :start_time, :empty_seats, :film_id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @start_time = options["start_time"]
    @film_id = options["film_id"].to_i
    @theatre_id = options["theatre_id"]
    @empty_seats = 0
  end


  def get_theatre_available_seats()
    sql = "SELECT theatres.available_seats FROM
           theatres INNER JOIN screenings
           ON screenings.theatre_id = theatres.id
           WHERE theatres.id = $1"
    values = [@theatre_id]
    available_seats = SqlRunner.run(sql,values)[0]["available_seats"].to_i
    return available_seats
  end

  def save()
    sql = "INSERT INTO screenings
           (start_time,empty_seats,film_id,theatre_id)
           VALUES ($1,$2,$3,$4) RETURNING *"
    values = [@start_time,@empty_seats,@film_id,@theatre_id]
    screening = SqlRunner.run(sql,values).first
    @id = screening["id"].to_i
    @empty_seats = self.get_theatre_available_seats()
    self.update 
  end

  def delete()
    sql = "DELETE FROM screenings WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

  def update()
    sql = "UPDATE screenings
           SET (start_time,empty_seats,film_id,theatre_id)
           = ($1,$2,$3,$4)
           WHERE id = $5"
    values = [@start_time,@empty_seats,@film_id,@theatre_id,@id]
    SqlRunner.run(sql,values)
  end


  # Class methods
  def self.all()
    sql = "SELECT * FROM screenings"
    values = []
    screenings = SqlRunner.run(sql, values)
    return screenings.map { |screening| Screening.new(screening) }
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    values = []
    SqlRunner.run(sql, values)
  end


end
