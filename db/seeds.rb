require('pry')
require_relative('../models/customer')
require_relative('../models/film')
require_relative('../models/ticket')

Ticket.delete_all
Customer.delete_all
Film.delete_all

customer1 = Customer.new({'name' => 'George', 'funds' => '60.00'})

customer2 = Customer.new({'name' => 'Roger', 'funds' => '800.00'})
# binding.pry
customer1.save
customer2.save

Customer.all

film1 = Film.new({'title' => 'Pulp Fiction', 'price' => '7.00'})
film2 = Film.new({'title' => 'Django Unchained', 'price' => '6.00'})

film1.save
film2.save
Film.all

ticket1 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film1.id})
ticket2 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})

ticket1.save
ticket2.save

Ticket.all

film1.customers
customer1.films
binding.pry
nil

