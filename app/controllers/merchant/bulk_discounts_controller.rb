class Merchant::BulkDiscountsController < ApplicationController
  before_action :find_merchant
  before_action :find_bulk_discount, only: [:show, :edit, :update]

  def index
    @bulk_discounts = @merchant.bulk_discounts
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
  end

  def create
    @merchant.bulk_discounts.create!(bulk_discount_params_create)
    flash.notice = 'Bulk Discount Has Been Created!'
    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  def update
    if @bulk_discount.update(bulk_discount_params)
      flash.notice = "Succesfully Updated Discount Info!"
      redirect_to merchant_bulk_discount_path(@merchant, @bulk_discount)
    else
      flash.notice = "All fields must be completed, get your act together."
      redirect_to edit_merchant_bulk_discount_path(@merchant, @bulk_discount)
    end
  end

  def destroy
      BulkDiscount.destroy(params[:id])
      redirect_to merchant_bulk_discounts_path(@merchant)
    end

  private
  def set_bulk_discount
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def bulk_discount_params
    params.require(:bulk_discount).permit(:percent_discount, :quantity_threshold)
  end

  def bulk_discount_params_create
    params.permit(:percent_discount, :quantity_threshold)
  end

  def find_bulk_discount
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
