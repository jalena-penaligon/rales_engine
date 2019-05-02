class InvoiceItemsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :unit_price, :quantity, :item_id, :invoice_id

  attributes :unit_price do |object|
    object.unit_price = (object.unit_price.to_f/100).to_s
  end
end
