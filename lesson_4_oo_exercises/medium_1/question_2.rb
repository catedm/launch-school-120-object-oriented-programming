class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    @quantity = updated_count if updated_count >= 0
  end
end

ipods = InvoiceEntry.new("Apple Ipod", 2)
ipods.update_quantity(5)
p ipods.quantity
p ipods
ipods.update_quantity(7)
p ipods
