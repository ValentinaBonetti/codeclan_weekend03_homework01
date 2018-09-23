require_relative("../db/sql_runner")

class Theatre

  attr_reader :id
  attr_accessor :theatre_number, :available_seats

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @theatre_number = options["theatre_number"]
    @available_seats = options["available_seats"]
  end

  def save()
    sql = "INSERT INTO theatres (theatre_number,available_seats) VALUES ($1,$2) RETURNING *"
    values = [@theatre_number,@available_seats]
    theatre = SqlRunner.run(sql,values).first
    @id = theatre["id"].to_i
  end

  def delete()
    sql = "DELETE FROM theatres WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

  def update()
    sql = "UPDATE theatres SET (theatre_number,available_seats) = ($1,$2)
           WHERE id = $3"
    values = [@theatre_number,@available_seats]
    SqlRunner.run(sql,values)
  end



  # Class methods
  def self.all()
    sql = "SELECT * FROM theatres"
    values = []
    theatres = SqlRunner.run(sql, values)
    return theatres.map { |theatre| Theatre.new(theatre) }
  end

  def self.delete_all()
    sql = "DELETE FROM theatres"
    values = []
    SqlRunner.run(sql, values)
  end

end
