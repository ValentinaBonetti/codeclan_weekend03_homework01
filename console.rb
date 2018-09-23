require_relative("models/film")
require_relative("models/customer")
require_relative("models/screening")
require_relative("models/ticket")
require_relative("models/theatre")

require("pry")

Ticket.delete_all()
Screening.delete_all()
Customer.delete_all()
Film.delete_all()
Theatre.delete_all()


film1 = Film.new({"title" => "Priscilla queen of the desert", "price" => 10})
film1.save

film2 = Film.new({"title" => "The Incredible Army of Brancaleone", "price" => 8})
film2.save

customer1 = Customer.new("name" => "Bob Kennedy", "wallet" => 150)
customer1.save

customer2 = Customer.new("name" => "Mohammed Sadi", "wallet" => 57)
customer2.save

theatre1 = Theatre.new({"theatre_number" => "1", "available_seats" => 130})
theatre2 = Theatre.new({"theatre_number" => "2", "available_seats" => 20})
theatre3 = Theatre.new({"theatre_number" => "3", "available_seats" => 250})
theatre1.save
theatre2.save
theatre3.save

screening1=Screening.new({"start_time" => "3:00","empty_seats" => 10, "film_id" => film1.id})
screening1.save

screening2=Screening.new({"start_time" => "4:50","empty_seats" => 21, "film_id" => film2.id})
screening2.save

ticket1 = Ticket.new({"customer_id" => customer1.id, "screening_id" => screening1.id})
ticket1.save

ticket2 = Ticket.new({"customer_id" => customer2.id, "screening_id" => screening2.id})
ticket2.save

ticket3 = Ticket.new({"customer_id" => customer2.id, "screening_id" => screening1.id})
ticket3.save

binding.pry
nil
