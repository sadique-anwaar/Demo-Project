class OrderItemsController < ApplicationController
	def create
		@order = current_order
		@order_item = @order.order_items.new(order_item_params)
		@order_item.save
	end

	def update
		@order = current_order
		@order_item = @order.order_items.find(params[:id])
		@order_item.update(quantity: params[:quantity])

		if @order_item.errors.any?
			message = @order_item.errors.full_messages.join(', ') 
		end

		respond_to do |format|
			format.json { render json: { message: message, item_total: @order_item.total_price , order_total: @order.subtotal, quantity: @order_item.quantity  } }
		end
	end

	def destroy
		@order = current_order
		@order_item = @order.order_items.find(params[:id])
		@order_item.destroy
		@order_items = @order.order_items
		redirect_to cart_path
	end

	private
		def order_item_params
			params.require(:order_item).permit(:product_id , :quantity)
		end
end

