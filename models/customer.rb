require_relative("../db/sql_runner")

class Customer

  attr_reader :id
  attr_accessor :name, :wallet #check: do we need total access?

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
    @wallet = options["wallet"]
  end

  def save()
    sql = "INSERT INTO customers (name,wallet) VALUES ($1,$2) RETURNING *"
    values = [@name,@wallet]
    customer = SqlRunner.run(sql,values).first
    @id = customer["id"].to_i
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

  def update()
    sql = "UPDATE customers SET (name,wallet) = ($1,$2)
           WHERE id = $3"
    values = [@name,@wallet,@id]
    SqlRunner.run(sql,values)
  end

end
