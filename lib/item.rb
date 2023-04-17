class Item
  attr_reader :name
  def initialize(details)
    @name = details[:name]
    @price = details[:price]
  end

  def price
    @price.slice!(0)
    @price.to_f
  end
end