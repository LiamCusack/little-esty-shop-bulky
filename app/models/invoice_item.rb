class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status

  belongs_to :invoice
  belongs_to :item

  enum status: [:pending, :packaged, :shipped]

  def self.incomplete_invoices
    Invoice.joins(:invoice_items)
           .where("invoice_items.status = 0 or invoice_items.status = 1")
           .order(:created_at)
           .distinct
  end

  def find_invoice_item_applied_discounts_id
    if self.item.merchant_id == self.invoice.merchant_id
      discount = Merchant.where(id: self.invoice.merchant_id)
              .joins(:bulk_discounts, invoices: :invoice_items)
              .select('bulk_discounts.percent_discount')
              .where('bulk_discounts.quantity_threshold <= ?', self.quantity)
              .group('bulk_discounts.percent_discount, bulk_discounts.id')
              .order(percent_discount: :desc)
              .limit(1)
              .pluck('bulk_discounts.id')
              .join
      discount
    end.to_i
  end

  def applied_bulk_discount
    BulkDiscount.where(id: self.find_invoice_item_applied_discounts_id).first
  end
end
