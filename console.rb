require_relative("models/film")
require_relative("models/customer")
require_relative("models/screening")
require_relative("models/ticket")

require("pry")


film1 = Film.new({"title" => "Priscilla queen of the desert", "price" => 10})
film1.save

film2 = Film.new({"title" => "The Incredible Army of Brancaleone", "price" => 8})
film2.save

customer1 = Customer.new("name" => "Bob Kennedy", "wallet" => 150)
customer1.save

customer2 = Customer.new("name" => "Mohammed Sadi", "wallet" => 57)
customer2.save

screening1=Screening.new({"start_time" => "3:00","empty_seats" => 10, "film_id" => film1.id})
screening1.save

screening2=Screening.new({"start_time" => "4:50","empty_seats" => 21, "film_id" => film2.id})
screening2.save

ticket1 = Ticket.new({"customer_id" => customer1.id, "screening_id" => screening1.id})
ticket1.save

ticket2 = Ticket.new({"customer_id" => customer2.id, "screening_id" => screening2.id})
ticket2.save

binding.pry
nil
