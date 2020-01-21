class Order < ApplicationRecord
	has_many :order_items
	before_save :set_subtotal
	belongs_to :user
	before_destroy :update_product_quantity

	def subtotal
		order_items.collect {|order_item| order_item.valid? ?  (order_item.unit_price*order_item.quantity) : 0}.sum
	end


	private
		def set_subtotal
			self[:subtotal] = subtotal
		end

		def update_product_quantity
			order_items.each do |item|
				item.product.quantity -= item.quantity
				item.product.save
			end
		end
end