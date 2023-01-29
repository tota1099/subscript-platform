require './purchase.rb'
require './errors.rb'

RSpec.describe Purchase do
  describe "Add item" do
    it "Should throw PurchaseError::WrongFormat if try to add empty string" do
      purchase = Purchase.new

      expect {
        purchase.add("")
      }.to raise_error(WrongFormat)
    end
  end
end