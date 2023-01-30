require './lib/purchase.rb'

purchase = Purchase.new
select = 0

while (true)
  puts "\nInput the puchase:"
  purchase_item = gets.chomp
  begin
    purchase.add(purchase_item)
  rescue StandardError => error
    puts error.message
  end

  puts "\n\n###### Extract ######\n\n"
  puts purchase.extract
end