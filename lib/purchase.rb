require_relative './errors.rb'

class Purchase

  attr_accessor :items

  TAX_EXCEPTIONS = [
    "book",
    "chocolate bar",
    "imported boxes of chocolates",
    "packet of headache pills"
  ].freeze

  def initialize
    @items = []
  end

  def add(item)
    validate_format(item)
    @items.append(build_item_object(item))
    return true
  end

  def extract
    items_string = @items.map do |item|
      price_with_tax = item[:total_tax] + item[:total_price]
      "#{item[:amount]} #{item[:product]}: #{sprintf('%.2f', price_with_tax)}" 
    end
    total = @items.map { |item| item[:total_tax] + item[:total_price] }.sum
    total_tax = @items.map { |item| item[:total_tax] }.sum

    "#{items_string.join("\n")}\nSales Taxes: #{sprintf('%.2f', total_tax)}\nTotal: #{sprintf('%.2f', total)}"
  end

  private

  def validate_format(string)
    raise WrongFormat unless string.match(/\d .+ at [+-]?([0-9]*[.])?[0-9]+/)
  end

  def build_item_object(item)
    item_splitted = item.split(" at ")
    amount, *product = item_splitted[0].split()

    amount = amount.to_i
    product = product.join(" ")
    price = item_splitted[1].to_f
    total_price = price * amount

    item = {
      "amount": amount,
      "product": product,
      "price": price,
      "total_price": total_price,
      "basic_tax": 0,
      "import_tax": 0
    }

    unless TAX_EXCEPTIONS.include?(item[:product])
      item[:basic_tax] = item[:total_price] * 0.10
    end

    if item[:product].include? "imported"
      item[:import_tax] = item[:total_price] * 0.05
    end

    item[:total_tax] = round_05(item[:import_tax] + item[:basic_tax])

    item
  end

  def round_05(value)
    (value * 20.0).round / 20.0
  end
end