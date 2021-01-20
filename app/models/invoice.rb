class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :merchant_id,
                        :customer_id

  belongs_to :merchant
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: [:cancelled, :in_progress, :complete]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def discount_revenue
    invoice_items.sum do |invoice_item|
      if invoice_item.item.merchant_id == self.merchant_id
        discount = Merchant.where(id: self.merchant_id)
                .joins(:bulk_discounts, invoices: :invoice_items)
                .select('bulk_discounts.percent_discount')
                .where('bulk_discounts.quantity_threshold <= ?', invoice_item.quantity)
                .group('bulk_discounts.percent_discount')
                .order(percent_discount: :desc)
                .limit(1)
                .pluck(:percent_discount)
                .join
                .to_f
        (invoice_item.quantity * invoice_item.unit_price) * ((100 - discount)/100)
      else
        (invoice_item.quantity * invoice_item.unit_price)
      end
    end
  end
end
