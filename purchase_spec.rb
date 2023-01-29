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
          "amount": 2
        }
      ])
    end
  end
end