require 'rails_helper'

describe 'Merchant bulk discount edit' do
  before :each do
    @m1 = Merchant.create!(name: 'Merchant 1')
    @bkd1 = BulkDiscount.create!(merchant_id: @m1.id, percent_discount: 10.0, quantity_threshold: 10)

    visit "/merchant/#{@m1.id}/bulk_discounts/#{@bkd1.id}/edit"
  end

  it 'should have a form that redirects back to merchant bulk discount show' do
    fill_in 'bulk_discount[percent_discount]', with: 11
    fill_in 'bulk_discount[quantity_threshold]', with: 11
    click_button

    expect(current_path).to eq("/merchant/#{@m1.id}/bulk_discounts/#{@bkd1.id}")
    expect(page).to have_content(11)
    expect(page).to have_content(11.0)
  end
end
