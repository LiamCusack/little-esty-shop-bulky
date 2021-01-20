BulkDiscount.destroy_all


@bd1 = BulkDiscount.create!(percent_discount: 5.0, quantity_threshold: 5, merchant_id: 1)
@bd2 = BulkDiscount.create!(percent_discount: 10.0, quantity_threshold: 10, merchant_id: 1)
@bd3 = BulkDiscount.create!(percent_discount: 20.0, quantity_threshold: 20, merchant_id: 1)
@bd4 = BulkDiscount.create!(percent_discount: 25.0, quantity_threshold: 25, merchant_id: 1)
@bd5 = BulkDiscount.create!(percent_discount: 30.0, quantity_threshold: 30, merchant_id: 1)
@bd6 = BulkDiscount.create!(percent_discount: 50.0, quantity_threshold: 50, merchant_id: 1)
@bd7 = BulkDiscount.create!(percent_discount: 75.0, quantity_threshold: 75, merchant_id: 1)
@bd8 = BulkDiscount.create!(percent_discount: 90.0, quantity_threshold: 90, merchant_id: 1)
@bd9 = BulkDiscount.create!(percent_discount: 33.3, quantity_threshold: 30, merchant_id: 1)
@bd10 = BulkDiscount.create!(percent_discount: 66.6, quantity_threshold: 50, merchant_id: 1)
