require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "validations" do
    it { should validate_presence_of :status }
    it { should validate_presence_of :merchant_id }
    it { should validate_presence_of :customer_id }
  end
  describe "relationships" do
    it { should belong_to :merchant }
    it { should belong_to :customer }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many :transactions}
  end
  describe "instance methods" do
    before :each do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
      @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @invoice_1 = Invoice.create!(merchant_id: @merchant1.id, customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
      @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 1, unit_price: 10, status: 1)
      @bkd1 = BulkDiscount.create!(merchant_id: @merchant1.id, percent_discount: 10.0, quantity_threshold: 10)
      @bkd1 = BulkDiscount.create!(merchant_id: @merchant1.id, percent_discount: 5.0, quantity_threshold: 5)
    end
    it "total_revenue" do
      expect(@invoice_1.total_revenue).to eq(100)
    end

    it "discount_revenue" do
      expect(@invoice_1.discount_revenue).to eq(95.5)
    end
  end
end
