require_relative("../db/sql_runner")

class Screening

  attr_reader :id
  attr_accessor :start_time, :empty_seats, :film_id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @start_time = options["start_time"]
    @empty_seats = options["empty_seats"]
    @film_id = options["film_id"].to_i
  end

  def save()
    sql = "INSERT INTO screenings
           (start_time,empty_seats,film_id)
           VALUES ($1,$2,$3) RETURNING *"
    values = [@start_time,@empty_seats,@film_id]
    screening = SqlRunner.run(sql,values).first
    @id = screening["id"].to_i
  end

  def delete()
    sql = "DELETE FROM screenings WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

  def update()
    sql = "UPDATE screenings
           SET (start_time,empty_seats,film_id)
           = ($1,$2,$3)
           WHERE id = $4"
    values = [@start_time,@empty_seats,@film_id,@id]
    SqlRunner.run(sql,values)
  end

end
