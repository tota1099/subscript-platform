require './errors.rb'

class Purchase

  attr_accessor :items

  def initialize
    @items = []
  end

  def add(item)
    validate_format(item)
    @items.append(build_item_object(item))
    return true
  end

  private

  def validate_format(string)
    raise WrongFormat unless string.match(/\d .+ at [+-]?([0-9]*[.])?[0-9]+/)
  end

  def build_item_object(item)
    item_splitted = item.split(" at ")
    amount, *product = item_splitted[0].split()

    {
      "amount": amount.to_i,
      "product": product.join,
      "price": item_splitted[1].to_f
    }
  end
end