class WrongFormat < StandardError
  def message
    "Wrong format! The correct format is: \n" +
    "{amount} {product name} at {price}. \n\n" +
    "Example: 3 boxes of chocolate at 11.25"
  end
end