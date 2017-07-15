require ('pg')
require('pry')
require_relative ('./customer')
require_relative ('./sqlrunner')
require_relative ('./ticket')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)

    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_f

  end

  def save
    sql = "INSERT INTO films (title, price) 
    VALUES ('#{@title}', #{@price}) RETURNING id";
    film = SqlRunner.run(sql).first
    @id = film['id'].to_i
  end

  def update
    sql = "UPDATE films SET (title, price) = ('#{@title}', #{@price})
      WHERE id = #{id};"
    updated_film = SqlRunner.run(sql)
    return updated_film
  end

  def customers
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets ON tickets.customer_id = customers.id
    WHERE film_id = #{id};"
    customers = SqlRunner.run(sql)
    result = customers.map { |customer| Customer.new(customer) }
    return result
  end

  def self.all
    sql = "SELECT * FROM films;"
    films = SqlRunner.run(sql)
    result = films.map { |film| Film.new(film) }
    return result
  end

  def self.delete_all
    sql = "DELETE FROM films;"
    SqlRunner.run(sql)
  end

end