require 'date'
class Market  
  attr_reader :name, :vendors, :date
  def initialize(name)
    @name = name
    @vendors = []
    @date = Date.today
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.check_stock(item) > 0
    end
  end

  def sorted_item_list
    items = []
    @vendors.map do |vendor|
      vendor.inventory.each do |item, amount|
        items << item.name
      end
    end
    items.uniq.sort
  end

  def vendors_that_sell_name(item)
    vendors_that_sell(item).map do |vendor|
      vendor.name
    end
  end

  def total_inventory
    inventory = {}
    @vendors.each do |vendor|
      vendor.inventory.each do |item, amount|
        if inventory[item]
          inventory[item][:quantity] += vendor.check_stock(item)
        else
        inventory[item] = {quantity: vendor.check_stock(item), vendors: vendors_that_sell_name(item)}
        end
      end
    end
    inventory
  end

  def overstocked_items
    inventory = {}
    over_items = []
    @vendors.each do |vendor|
      vendor.inventory.each do |item, amount|
        if inventory[item]
          inventory[item][:quantity] += vendor.check_stock(item)
        else
        inventory[item] = {quantity: vendor.check_stock(item), vendors: vendors_that_sell_name(item)}
        end
      end
    end
    inventory.each do |item, hash|
      if hash[:quantity] > 50 && hash[:vendors].length >1
        over_items << item
      end
    end
    over_items
  end
end