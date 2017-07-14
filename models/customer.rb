require ('pg')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
  
  @id = options['id'].to_i
  @name = options['name']
  @funds = options['funds'].to_f

  end

  def save
    sql = "INSERT INTO customers (name, funds) VALUES ('#{@name}', #{@funds}) RETURNING id"
    user = SqlRunner.run(sql).first
    @id = user['id'].to_i
  end



end