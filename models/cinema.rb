require_relative("../db/sql_runner")

class Cinema

  attr_reader :id
  attr_accessor :name, :theatres_list, :till

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
    @theatres = options["theatres_list"]
    @till = options["till"] || 0
  end

  def save()
    sql = "INSERT INTO cinemas (name,theatres_list,till) VALUES ($1,$2,$3) RETURNING *"
    values = [@name,@theatres_list,@till]
    cinema = SqlRunner.run(sql,values).first
    @id = cinema["id"].to_i
  end

  def delete()
    sql = "DELETE FROM cinemas WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

  def update()
    sql = "UPDATE cinemas SET (name,theatres_list,till) = ($1,$2,$3)
           WHERE id = $4"
    values = [@name,@theatres_list,@till,@id]
    SqlRunner.run(sql,values)
  end



  # Class methods
  def self.all()
    sql = "SELECT * FROM cinemas"
    values = []
    cinemas = SqlRunner.run(sql, values)
    return cinemas.map { |cinema| Cinema.new(cinema) }
  end

  def self.delete_all()
    sql = "DELETE FROM cinemas"
    values = []
    SqlRunner.run(sql, values)
  end

end
