require './lib/purchase.rb'
require './lib/errors.rb'

RSpec.describe Purchase do
  describe "Add item" do
    it "Should throw PurchaseError::WrongFormat if try to add empty string" do
      purchase = Purchase.new

      error_message = "Wrong format! The correct format is: \n" +
                      "{amount} {product name} at {price}. \n\n" +
                      "Example: 3 boxes of chocolate at 11.25"

      expect {
        purchase.add("")
      }.to raise_error(WrongFormat, error_message)
    end

    it "Should throw PurchaseError::WrongFormat if try to add wrong format string" do
      purchase = Purchase.new

      error_message = "Wrong format! The correct format is: \n" +
                      "{amount} {product name} at {price}. \n\n" +
                      "Example: 3 boxes of chocolate at 11.25"

      expect {
        purchase.add("any format")
      }.to raise_error(WrongFormat, error_message)
    end

    it "Should add item if try to add with correct format" do
      purchase = Purchase.new
      expect(purchase.add("2 book at 12.49")).to eq(true)
    end

    it "Should add item in the list" do
      purchase = Purchase.new
      purchase.add("2 book at 12.49")

      expect(purchase.send(:items)).to eq([
        {
          "product": "book",
          "price": 12.49,
          "amount": 2,
          "total_price": 24.98,
          "basic_tax": 0,
          "import_tax": 0,
          "total_tax": 0.0
        }
      ])
    end

    it "Should add multiple items in the list" do
      purchase = Purchase.new
      purchase.add("2 book at 12.49")
      purchase.add("1 imported bottle of perfume at 47.50")
      purchase.add("3 boxes of chocolate at 11.25")

      expect(purchase.send(:items)).to eq([
        {
          "product": "book",
          "price": 12.49,
          "basic_tax": 0,
          "total_price": 24.98,
          "amount": 2,
          "import_tax": 0,
          "total_tax": 0
        },
        {
          "product": "imported bottle of perfume",
          "price": 47.50,
          "basic_tax": 4.75,
          "total_price": 47.50,
          "amount": 1,
          "import_tax": 2.375,
          "total_tax": 7.15
        },
        {
          "product": "boxes of chocolate",
          "price": 11.25,
          "amount": 3,
          "basic_tax": 3.375,
          "total_price": 33.75,
          "import_tax": 0,
          "total_tax": 3.4
        }
      ])
    end
  end

  describe "Extract" do
    it "Should return no items added if call extract without add any item" do
      purchase = Purchase.new
      expect(purchase.extract).to eq("No items added!")
    end

    it "Should show the products with correct format" do
      purchase = Purchase.new
      purchase.add("2 book at 12.49")
      purchase.add("1 music CD at 14.99")
      purchase.add("1 chocolate bar at 0.85")

      expect(purchase.extract).to eq(
        "2 book: 24.98" + "\n" +
        "1 music CD: 16.49" + "\n" +
        "1 chocolate bar: 0.85" + "\n" +
        "Sales Taxes: 1.50" + "\n" +
        "Total: 42.32"
      )

      purchase = Purchase.new
      purchase.add("1 imported boxes of chocolates at 10.00")
      purchase.add("1 imported bottle of perfume at 47.50")

      expect(purchase.extract).to eq(
        "1 imported boxes of chocolates: 10.50" + "\n" +
        "1 imported bottle of perfume: 54.65" + "\n" +
        "Sales Taxes: 7.65" + "\n" +
        "Total: 65.15"
      )

      purchase = Purchase.new
      purchase.add("1 imported bottle of perfume at 27.99")
      purchase.add("1 bottle of perfume at 18.99")
      purchase.add("1 packet of headache pills at 9.75")
      purchase.add("3 imported boxes of chocolates at 11.25")

      expect(purchase.extract).to eq(
        "1 imported bottle of perfume: 32.19" + "\n" +
        "1 bottle of perfume: 20.89" + "\n" +
        "1 packet of headache pills: 9.75" + "\n" +
        "3 imported boxes of chocolates: 35.45" + "\n" +
        "Sales Taxes: 7.80" + "\n" +
        "Total: 98.28"
      )
    end
  end
end