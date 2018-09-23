require_relative("../db/sql_runner")

class Film

  attr_reader :id
  attr_accessor :title, :price #check: do we need total access?

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @title = options["title"]
    @price = options["price"]
  end

  def save()
    sql = "INSERT INTO films (title,price) VALUES ($1,$2) RETURNING *"
    values = [@title,@price]
    film = SqlRunner.run(sql,values).first
    @id = film["id"].to_i
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

  def update()
    sql = "UPDATE films SET (title,price) = ($1,$2)
    WHERE id = $3"
    values = [@title,@price,@id]
    SqlRunner.run(sql,values)
  end


  # Which customers are coming to see one film
  def customers_coming()
    sql = "SELECT customers.* FROM
            customers INNER JOIN tickets
            ON customers.id = tickets.customer_id
            INNER JOIN screenings
            ON tickets.screening_id = screenings.id
            WHERE screenings.film_id = $1"
    values = [@id]
    customers_coming = SqlRunner.run(sql,values)
    return customers_coming.map{|customer| Customer.new(customer)}
  end

  def count_customers_coming()
    customers = self.customers_coming
    return customers.length
  end

  # Class methods
  def self.all()
    sql = "SELECT * FROM films"
    values = []
    films = SqlRunner.run(sql, values)
    return films.map { |film| Film.new(film) }
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    values = []
    SqlRunner.run(sql, values)
  end

end
