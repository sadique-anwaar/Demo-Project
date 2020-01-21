class ChargesController < ApplicationController

	def new
		@total = current_order.subtotal
	end
	
	def validate_coupon
		@amount = params[:total].to_i
	  @final_amount = @amount

	  @code = params[:couponCode]

	  if !@code.blank?
		  @coupon = Coupon.get(@code)
		    if @coupon.nil?
		    	flash.now[:alert] = 'Invalid or expired coupon.'
		    else
		      @final_amount = @coupon.apply_discount(@amount.to_i)
	    	  @discount_amount = (@amount - @final_amount)
	    	  message = 'Coupon applied.'
		    end
		end

	def create

	  @amount = params[:discouned_total].to_i * 100
	  @coupon = Coupon.get(params[:couponCode])
	  @final_amount = @coupon&.apply_discount(@amount) || @amount
	  @discount_amount = (@amount - @final_amount)

	
	  customer = Stripe::Customer.create({
	    email: params[:stripeEmail],
	    source: params[:stripeToken],
	  })

	  charge = Stripe::Charge.create({
	    customer: customer.id,
	    amount: @amount.to_i,
	    description: 'Rails Stripe customer',
	    currency: 'usd',
	  })

	  current_order.destroy
	  session[:order_id] = nil

		rescue Stripe::CardError => e
  		flash[:error] = e.message
  		redirect_to new_charge_path
	end

		

		respond_to do |format|
			format.json { render json: { message: message, final_amount: @final_amount, discount: @coupon.discount_percent_human } }
		end
	end
end
