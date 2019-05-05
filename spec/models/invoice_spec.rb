require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it { should belong_to :customer }

  describe 'calculations' do
    before(:each) do
      @customer = create(:customer)

      @merchant_1 = create(:merchant)
      @item_1 = create(:item, merchant: @merchant_1, unit_price: 12)
      @invoice_1 = create(:invoice, merchant: @merchant_1, customer: @customer)
      @transaction_1 = create(:transaction, invoice: @invoice_1, result: 0)
      @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, quantity: 2, unit_price: 10, created_at: "2012-03-27 14:54:09 UTC")
      @invoice_01 = create(:invoice, merchant: @merchant_1, customer: @customer)
      @invoice_item_01 = create(:invoice_item, item: @item_1, invoice: @invoice_1, quantity: 2, unit_price: 10)

      @merchant_2 = create(:merchant)
      @item_2 = create(:item, merchant: @merchant_2, unit_price: 4)
      @invoice_2 = create(:invoice, merchant: @merchant_2, customer: @customer)
      @transaction_2 = create(:transaction, invoice: @invoice_2, result: 0)
      @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice_2, quantity: 5, unit_price: 5, created_at: "2012-03-27 14:54:09 UTC")
      @invoice_02 = create(:invoice, merchant: @merchant_2, customer: @customer)
      @invoice_item_02 = create(:invoice_item, item: @item_2, invoice: @invoice_2, quantity: 5, unit_price: 5)

      @merchant_3 = create(:merchant)
      @item_3 = create(:item, merchant: @merchant_3, unit_price: 6)
      @invoice_3 = create(:invoice, merchant: @merchant_3, customer: @customer)
      @transaction_3 = create(:transaction, invoice: @invoice_3, result: 0)
      @invoice_item_3 = create(:invoice_item, item: @item_3, invoice: @invoice_3, quantity: 3, unit_price: 2, created_at: "2012-03-27 14:54:09 UTC")
      @invoice_03 = create(:invoice, merchant: @merchant_3, customer: @customer)
      @invoice_item_03 = create(:invoice_item, item: @item_3, invoice: @invoice_3, quantity: 3, unit_price: 2)
    end

    it 'can calculate revenue for all merchants by date' do
      date = "2012-03-27".to_datetime

      expect(Invoice.revenue(date)[0].total_revenue).to eq(51)
    end
  end
end
