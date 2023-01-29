require './purchase.rb'
require './errors.rb'

RSpec.describe Purchase do
  describe "Add item" do
    it "Should throw PurchaseError::WrongFormat if try to add empty string" do
      purchase = Purchase.new

      expect {
        purchase.add("")
      }.to raise_error(WrongFormat, "Wrong format!")
    end

    it "Should throw PurchaseError::WrongFormat if try to add wrong format string" do
      purchase = Purchase.new

      expect {
        purchase.add("any format")
      }.to raise_error(WrongFormat, "Wrong format!")
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
          "import_tax": 0
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
          "import_tax": 0
        },
        {
          "product": "imported bottle of perfume",
          "price": 47.50,
          "basic_tax": 4.75,
          "total_price": 47.50,
          "amount": 1,
          "import_tax": 2.375
        },
        {
          "product": "boxes of chocolate",
          "price": 11.25,
          "amount": 3,
          "basic_tax": 3.375,
          "total_price": 33.75,
          "import_tax": 0
        }
      ])
    end
  end

  describe "Extract" do
    it "Should show the products with correct format" do
      purchase = Purchase.new
      purchase.add("2 book at 12.49")
      purchase.add("1 imported bottle of perfume at 47.50")
      purchase.add("3 boxes of chocolate at 11.25")

      expect(purchase.extract).to eq(
        "2 book: 24.98" + "\n" +
        "1 imported bottle of perfume: 52.25" + "\n" +
        "3 boxes of chocolate: 37.12" + "\n" +
        "Total: 114.36"
      )
    end
  end
end