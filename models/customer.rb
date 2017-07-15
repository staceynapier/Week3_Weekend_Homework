require ('pg')
require_relative('./sqlrunner')
require_relative ('./film')
require_relative ('./ticket')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
  
  @id = options['id'].to_i if options['id']
  @name = options['name']
  @funds = options['funds'].to_f

  end

  def save
    sql = "INSERT INTO customers (name, funds) VALUES ('#{@name}', #{@funds}) RETURNING id;"
    customer = SqlRunner.run(sql).first
    @id = customer['id'].to_i
  end

  def update
    sql = "UPDATE customers SET (name, funds) = ('#{@name}', #{@funds})
      WHERE id = #{id};"
    updated_customer = SqlRunner.run(sql)
    return updated_customer
  end

  def films
    sql = "SELECT films.* FROM films
    INNER JOIN tickets ON tickets.film_id = films.id
    WHERE customer_id = #{id};"
    films = SqlRunner.run(sql)
    result = films.map { |film| Film.new(film) }
    return result
  end

  def self.all
    sql = "SELECT * FROM customers;"
    customers = SqlRunner.run(sql)
    result = customers.map { |customer| Customer.new(customer) }
    return result
  end

  def self.delete_all
    sql = "DELETE FROM customers;"
    SqlRunner.run(sql)
  end

end