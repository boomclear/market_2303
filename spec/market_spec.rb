require "./lib/item"
require "./lib/vendor"
require "./lib/market"

RSpec.describe Market do
  it "exists" do 
    market = Market.new("South Pearl Street Farmers Market") 

    expect(market).to be_a(Market)
  end

  it "has attributes" do 
    market = Market.new("South Pearl Street Farmers Market") 

    expect(market.name).to eq("South Pearl Street Farmers Market")
    expect(market.vendors).to eq([])
  end

  it "can add vendors and list their attributes" do
    market = Market.new("South Pearl Street Farmers Market") 
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: "$0.50"})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7) 
    vendor2 = Vendor.new("Ba-Nom-a-Nom")
    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)
    vendor3 = Vendor.new("Palisade Peach Shack") 
    vendor3.stock(item1, 65) 
    market.add_vendor(vendor1) 
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)
    
    expect(market.vendors).to eq([vendor1, vendor2, vendor3])
    expect(market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    expect(market.vendors_that_sell(item1)).to eq([vendor1, vendor3])
    expect(market.vendors_that_sell(item4)).to eq([vendor2])
  end

  it "can show names of all items in stock sorted" do
    market = Market.new("South Pearl Street Farmers Market") 
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: "$0.50"})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7) 
    vendor2 = Vendor.new("Ba-Nom-a-Nom")
    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)
    vendor3 = Vendor.new("Palisade Peach Shack") 
    vendor3.stock(item1, 65) 
    market.add_vendor(vendor1) 
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)

    expect(market.sorted_item_list).to eq(["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"])
  end

  it "can show total inventory" do
    market = Market.new("South Pearl Street Farmers Market") 
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: "$0.50"})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7) 
    vendor2 = Vendor.new("Ba-Nom-a-Nom")
    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)
    vendor3 = Vendor.new("Palisade Peach Shack") 
    vendor3.stock(item1, 65) 
    market.add_vendor(vendor1) 
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)

    expected = {item1 => {quantity: 100, vendors: ["Rocky Mountain Fresh", "Palisade Peach Shack"]},
    item2 => {quantity: 7, vendors: ["Rocky Mountain Fresh"]},
    item3 => {quantity: 25, vendors: ["Ba-Nom-a-Nom"]},
    item4 => {quantity: 50, vendors: ["Ba-Nom-a-Nom"]}
  }
    expect(market.total_inventory).to eq(expected)
  end

  it "can show overstocked items" do 
    market = Market.new("South Pearl Street Farmers Market") 
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: "$0.50"})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7) 
    vendor2 = Vendor.new("Ba-Nom-a-Nom")
    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)
    vendor3 = Vendor.new("Palisade Peach Shack") 
    vendor3.stock(item1, 65) 
    market.add_vendor(vendor1) 
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)

    expect(market.overstocked_items).to eq([item1])
  end

  it "can show the date of creation" do 
    market = Market.new("Bazaar")

    expect(market.date).to eq(Date.today)
  end
end