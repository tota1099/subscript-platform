RSpec.describe Purchase do
  describe "Add item" do
    it "Should throw PurchaseError::WrongFormat if try to add empty string" do
      purchase = Game.Purchase

      expect {
        purchase.add("")
      }.to raise_error(PurchaseError::WrongFormat)
    end
  end
end