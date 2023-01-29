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
  end
end