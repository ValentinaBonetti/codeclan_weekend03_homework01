require_relative("models/film")
require_relative("models/customer")
require_relative("models/screening")
require_relative("models/ticket")

require("pry")


film1 = Film.new({"title" => "Priscilla queen of the desert", "price" => 10})
film1.save

customer1 = Customer.new("name" => "Bob Kennedy", "wallet" => 150)
customer1.save 

binding.pry
nil
